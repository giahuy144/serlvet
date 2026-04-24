<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Người Dùng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/users.css">
</head>
<body>

<%
    List<User> users = (List<User>) request.getAttribute("users");
    User currentUser = (User) request.getAttribute("user");
    List<Integer> followingIds = (List<Integer>) request.getAttribute("followingIds");
%>

<div class="page-wrapper">
    <h2>Danh sách người dùng</h2>

    <%
        for(User u : users){
    %>
        <div class="user">
            <div>
                <h4><%= u.getUsername() %></h4>
                <span>Vai trò: <%= u.getRole() %></span>
            </div>

            <%
                // Không hiển thị follow chính mình
                if(u.getId() != currentUser.getId()){
                    
                    boolean isFollowed = false;
                    if(followingIds != null){
                        isFollowed = followingIds.contains(u.getId());
                    }

                    if(isFollowed){
            %>
                        <span>Đã follow</span>
            <%
                    } else {
            %>
                        <form action="follow" method="post">
                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                            <button type="submit">Follow</button>
                        </form>
            <%
                    }
                }
            %>

        </div>
    <%
        }
    %>

    <a href="posts">← Quay lại trang bài viết</a>
</div>

</body>
</html>