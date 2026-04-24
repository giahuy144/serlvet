<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Post, model.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Diễn đàn - Kết nối & Chia sẻ</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/posts.css">
</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    List<User> suggestedUsers = (List<User>) request.getAttribute("suggestedUsers");
%>

<div class="header">
    <div class="logo">
        <i class="fas fa-comments"></i>
        <span>ConnectHub</span>
    </div>
    <div class="user-info">
        <i class="fas fa-user-circle" style="color: #3b82f6; font-size: 20px;"></i>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a href="http://localhost:8080/login" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            Đăng xuất
        </a>
    </div>
</div>

<div class="container">
  <div class="layout">

    <!-- LEFT SIDEBAR -->
    <aside class="sidebar">
      <div class="nav-card">
        <a class="nav-item" href="posts">
          <i class="fas fa-house"></i>
          <span>Trang chủ</span>
        </a>
        <a class="nav-item" href="users">
          <i class="fas fa-user-friends"></i>
          <span>Người dùng</span>
        </a>
      </div>
    </aside>

    <!-- MAIN -->
    <main class="main-col">

      <!-- FORM -->
      <div class="post-form">
        <h3>
            <i class="fas fa-pen-fancy"></i>
            Tạo bài viết mới
        </h3>

        <form action="posts" method="post">
            <div class="form-group">
                <input type="text" name="title" placeholder="Tiêu đề bài viết..." required>
            </div>

            <div class="form-group">
                <textarea name="body" rows="4" placeholder="Nội dung bài viết..."></textarea>
            </div>

            <div class="toggle-container">
                <span class="toggle-label">Trạng thái:</span>
                <label class="toggle-switch">
                    <input type="checkbox" name="status" value="published" checked>
                    <span class="toggle-slider"></span>
                </label>
                <span>Published</span>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-paper-plane"></i>
                Đăng bài ngay
            </button>
        </form>
      </div>

      <!-- HEADER POSTS -->
      <div class="posts-header">
        <h3>
            <i class="fas fa-newspaper"></i>
            Bài viết mới nhất
        </h3>
        <span class="post-count">
            <i class="fas fa-file-alt"></i> <%= posts.size() %> bài viết
        </span>
      </div>

      <!-- LOOP POSTS -->
      <%
          for(Post post : posts){
      %>
      <div class="post">

        <div class="content">
            <h4><%= post.getTitle() %></h4>

            <div class="meta">
                <span><i class="far fa-clock"></i> <%= post.getCreatedAt() %></span>

                <%
                    if("published".equals(post.getStatus())){
                %>
                    <span class="status-badge status-published-badge">
                        <i class="fas fa-globe"></i> Công khai
                    </span>
                <%
                    } else {
                %>
                    <span class="status-badge status-draft-badge">
                        <i class="fas fa-lock"></i> Bản nháp
                    </span>
                <%
                    }
                %>
            </div>

            <div class="post-body">
                <%= post.getBody() %>
            </div>

            <div class="post-actions">
                <button onclick="alert('Đã thích bài viết!')">
                    Thích
                </button>
                <button onclick="alert('Mở comment!')">
                    Bình luận
                </button>
                <button onclick="alert('Chia sẻ!')">
                    Chia sẻ
                </button>
            </div>
        </div>
      </div>
      <%
          }
      %>

      <hr>
      <div style="text-align: center;">
          Cảm ơn bạn đã tham gia diễn đàn!
      </div>

    </main>

    <!-- RIGHT -->
    <aside class="right-rail">
      <div class="right-card">
        <div class="suggestions">

          <div class="suggestions-header">
              <span>Gợi ý theo dõi</span>
          </div>

          <%
              if(suggestedUsers == null || suggestedUsers.isEmpty()){
          %>
              <div>Hiện không còn tài khoản nào để gợi ý.</div>
          <%
              } else {
                  for(User u : suggestedUsers){
          %>
              <form action="follow" method="post">
                  <span><%= u.getUsername() %></span>
                  <input type="hidden" name="userId" value="<%= u.getId() %>" />
                  <button type="submit">Follow</button>
              </form>
          <%
                  }
              }
          %>

        </div>
      </div>
    </aside>

  </div>
</div>

<script src="<%= request.getContextPath() %>/js/posts.js"></script>

</body>
</html>