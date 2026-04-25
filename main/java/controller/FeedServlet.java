package controller;

import dao.FeedDAO;
import dto.FeedPostDTO;
import model.User;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/feed")
public class FeedServlet extends HttpServlet {

    private FeedDAO feedDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        feedDAO = new FeedDAO();
        // Cần thêm Gson vào build.gradle: implementation 'com.google.code.gson:gson:2.10.1'
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String pageParam = request.getParameter("page");
        boolean isAjax = "true".equals(request.getHeader("X-Requested-With"))
                || pageParam != null;

        int page = 0;
        if (pageParam != null) {
            try { page = Integer.parseInt(pageParam); } catch (NumberFormatException ignored) {}
        }

        List<FeedPostDTO> posts = feedDAO.getFeedPaged(user.getId(), page);
        boolean hasMore = feedDAO.hasMore(user.getId(), page);

        if (isAjax && pageParam != null) {
            // Trả về JSON cho infinite scroll
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();

            Map<String, Object> result = new HashMap<>();
            result.put("posts", posts);
            result.put("hasMore", hasMore);
            result.put("nextPage", page + 1);

            out.print(gson.toJson(result));
            out.flush();
        } else {
            // Render trang JSP lần đầu
            request.setAttribute("user", user);
            request.setAttribute("posts", posts);
            request.setAttribute("hasMore", hasMore);
            request.setAttribute("currentPage", page);
            request.getRequestDispatcher("/WEB-INF/views/feed.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");

        if ("like".equals(action)) {
            int postId = Integer.parseInt(request.getParameter("postId"));
            boolean nowLiked = feedDAO.toggleLike(user.getId(), postId);

            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"liked\":" + nowLiked + "}");
            out.flush();
        }
    }
}