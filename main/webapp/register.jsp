<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng ký</title>
  <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --bg: #0d0d0d;
      --surface: #161616;
      --surface2: #1e1e1e;
      --border: #2a2a2a;
      --accent: #00e5a0;
      --accent-dim: rgba(0,229,160,0.12);
      --text: #f0f0f0;
      --text-muted: #666;
      --text-dim: #999;
      --danger: #ff4d6d;
      --font: 'Sora', sans-serif;
    }

    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 40px 36px;
      width: 100%;
      max-width: 400px;
    }

    .logo {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--accent);
      margin-bottom: 6px;
      letter-spacing: -0.03em;
    }
    .logo span { color: var(--text); }

    .subtitle {
      color: var(--text-muted);
      font-size: 0.85rem;
      margin-bottom: 28px;
    }

    .form-group {
      margin-bottom: 16px;
    }
    label {
      display: block;
      font-size: 0.8rem;
      font-weight: 600;
      color: var(--text-dim);
      margin-bottom: 6px;
      letter-spacing: 0.04em;
      text-transform: uppercase;
    }
    input {
      width: 100%;
      background: var(--surface2);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: 10px 14px;
      color: var(--text);
      font-family: var(--font);
      font-size: 0.9rem;
      transition: border-color 0.2s;
    }
    input:focus {
      outline: none;
      border-color: var(--accent);
    }

    .error-msg {
      background: rgba(255,77,109,0.1);
      border: 1px solid rgba(255,77,109,0.3);
      color: var(--danger);
      border-radius: 8px;
      padding: 10px 14px;
      font-size: 0.83rem;
      margin-bottom: 16px;
    }

    .btn {
      width: 100%;
      background: var(--accent);
      color: #000;
      border: none;
      border-radius: 8px;
      padding: 11px;
      font-family: var(--font);
      font-weight: 700;
      font-size: 0.9rem;
      cursor: pointer;
      margin-top: 8px;
      transition: opacity 0.2s;
    }
    .btn:hover { opacity: 0.85; }

    .footer-link {
      text-align: center;
      margin-top: 20px;
      font-size: 0.83rem;
      color: var(--text-muted);
    }
    .footer-link a {
      color: var(--accent);
      text-decoration: none;
      font-weight: 600;
    }
    .footer-link a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="card">
  <div class="logo">feed<span>.</span></div>
  <div class="subtitle">Tạo tài khoản mới</div>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error-msg">${error}</div>
  <% } %>

  <form action="register" method="post">
    <div class="form-group">
      <label>Tên đăng nhập</label>
      <input type="text" name="username" placeholder="Nhập tên đăng nhập..."
             value="${param.username}" required autofocus>
    </div>
    <div class="form-group">
      <label>Mật khẩu</label>
      <input type="password" name="password" placeholder="Ít nhất 6 ký tự..." required>
    </div>
    <div class="form-group">
      <label>Xác nhận mật khẩu</label>
      <input type="password" name="confirm" placeholder="Nhập lại mật khẩu..." required>
    </div>
    <button type="submit" class="btn">Đăng ký</button>
  </form>

  <div class="footer-link">
    Đã có tài khoản? <a href="login">Đăng nhập</a>
  </div>
</div>
</body>
</html>