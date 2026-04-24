package controller;

import dao.PostDAO;
import dao.UserDAO;
import dao.FollowDAO;
import model.Post;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/posts")
public class PostServlet extends HttpServlet {

    private PostDAO postDAO;
    private UserDAO userDAO;
    private FollowDAO followDAO;

    // Khởi tạo
    @Override
    public void init() throws ServletException {
        postDAO = new PostDAO();
        userDAO = new UserDAO();
        followDAO = new FollowDAO();
    }

    // ===================== GET =====================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        request.setAttribute("user", user);

        int userId = user.getId();

        // ===== Lấy danh sách bài viết =====
        List<Post> posts = postDAO.getFeedPosts(userId);
        request.setAttribute("posts", posts);

        // ===== Gợi ý follow =====
        List<User> allUsers = userDAO.getAllUsers();
        List<Integer> followingIds = followDAO.getFollowingList(userId);

        List<User> suggestedUsers = new ArrayList<>();

        if (allUsers != null) {
            for (User u : allUsers) {
                if (u.getId() != userId &&
                    (followingIds == null || !followingIds.contains(u.getId()))) {
                    suggestedUsers.add(u);
                }
            }
        }

        request.setAttribute("suggestedUsers", suggestedUsers);
        request.getRequestDispatcher("/WEB-INF/views/posts.jsp")
               .forward(request, response);
    }

    // ===================== POST =====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("doPost() được gọi");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String status = request.getParameter("status");

        if (title != null && !title.trim().isEmpty()) {
            if (status == null) {
                status = "draft"; // mặc định nếu không tick
            }
            postDAO.createPost(user.getId(), title, body, status);
        }

        response.sendRedirect("posts");
    }

    // Hủy
    @Override
    public void destroy() {
        // cleanup nếu cần
    }
}