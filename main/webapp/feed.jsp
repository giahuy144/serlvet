<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Feed</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        /* ===== CSS Variables ===== */
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
            --draft-badge: #f59e0b;
            --font: 'Sora', sans-serif;
            --mono: 'JetBrains Mono', monospace;
            --radius: 12px;
            --card-shadow: 0 4px 24px rgba(0,0,0,0.4);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: var(--font);
            min-height: 100vh;
        }

        /* ===== Topbar ===== */
        .topbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(13,13,13,0.85);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            padding: 0 24px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .logo {
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: -0.02em;
            color: var(--accent);
        }
        .logo span { color: var(--text); }
        .nav-links a {
            color: var(--text-dim);
            text-decoration: none;
            font-size: 0.85rem;
            margin-left: 20px;
            transition: color 0.2s;
        }
        .nav-links a:hover { color: var(--accent); }
        .nav-links a.active { color: var(--text); }
        .user-pill {
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: 999px;
            padding: 4px 14px 4px 4px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.82rem;
        }
        .avatar {
            width: 28px; height: 28px;
            border-radius: 50%;
            background: var(--accent-dim);
            border: 1px solid var(--accent);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--accent);
        }

        /* ===== Layout ===== */
        .layout {
            max-width: 1100px;
            margin: 0 auto;
            padding: 32px 24px;
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 32px;
        }

        /* ===== Feed Header ===== */
        .feed-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }
        .feed-title {
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: -0.03em;
        }
        .feed-title em {
            color: var(--accent);
            font-style: normal;
        }
        .filter-tabs {
            display: flex;
            gap: 4px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 3px;
        }
        .filter-tab {
            padding: 5px 14px;
            border-radius: 6px;
            border: none;
            background: none;
            color: var(--text-muted);
            font-family: var(--font);
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .filter-tab.active {
            background: var(--accent-dim);
            color: var(--accent);
        }

        /* ===== Post Card ===== */
        .post-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px 24px;
            margin-bottom: 16px;
            transition: border-color 0.2s, transform 0.2s;
            animation: cardIn 0.35s ease both;
        }
        .post-card:hover {
            border-color: #333;
            transform: translateY(-1px);
        }
        @keyframes cardIn {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .card-meta {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 14px;
        }
        .card-avatar {
            width: 34px; height: 34px;
            border-radius: 50%;
            background: var(--surface2);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--accent);
            flex-shrink: 0;
        }
        .card-author {
            font-weight: 600;
            font-size: 0.88rem;
        }
        .card-time {
            font-size: 0.75rem;
            color: var(--text-muted);
            font-family: var(--mono);
        }
        .badge {
            margin-left: auto;
            padding: 2px 10px;
            border-radius: 999px;
            font-size: 0.7rem;
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        .badge-draft {
            background: rgba(245,158,11,0.12);
            color: var(--draft-badge);
            border: 1px solid rgba(245,158,11,0.3);
        }
        .badge-own {
            background: var(--accent-dim);
            color: var(--accent);
            border: 1px solid rgba(0,229,160,0.3);
        }

        .card-title {
            font-size: 1.05rem;
            font-weight: 700;
            letter-spacing: -0.02em;
            margin-bottom: 8px;
            line-height: 1.4;
        }
        .card-body {
            font-size: 0.88rem;
            color: var(--text-dim);
            line-height: 1.65;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .card-actions {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-top: 16px;
            padding-top: 14px;
            border-top: 1px solid var(--border);
        }
        .action-btn {
            display: flex;
            align-items: center;
            gap: 6px;
            background: none;
            border: none;
            color: var(--text-muted);
            font-family: var(--font);
            font-size: 0.82rem;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .action-btn:hover { background: var(--surface2); color: var(--text); }
        .action-btn.liked {
            color: var(--danger);
        }
        .action-btn.liked svg { fill: var(--danger); }
        .like-count, .comment-count { font-family: var(--mono); font-size: 0.78rem; }

        /* ===== Load more / Spinner ===== */
        .feed-footer {
            text-align: center;
            padding: 32px 0;
        }
        .spinner {
            display: none;
            width: 28px; height: 28px;
            border: 2px solid var(--border);
            border-top-color: var(--accent);
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
            margin: 0 auto 12px;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
        .spinner.active { display: block; }
        .end-msg {
            display: none;
            color: var(--text-muted);
            font-size: 0.8rem;
            font-family: var(--mono);
        }
        .end-msg.show { display: block; }

        /* ===== Sidebar ===== */
        .sidebar-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 18px 20px;
            margin-bottom: 16px;
        }
        .sidebar-title {
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 14px;
        }
        .suggest-user {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
        }
        .suggest-user:last-child { border-bottom: none; }
        .suggest-name { font-size: 0.85rem; font-weight: 600; }
        .follow-btn {
            background: var(--accent-dim);
            border: 1px solid rgba(0,229,160,0.3);
            color: var(--accent);
            border-radius: 6px;
            padding: 3px 12px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            font-family: var(--font);
            transition: all 0.2s;
        }
        .follow-btn:hover { background: var(--accent); color: #000; }

        /* ===== Compose area ===== */
        .compose-box {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 16px 20px;
            margin-bottom: 24px;
        }
        .compose-box textarea {
            width: 100%;
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            color: var(--text);
            font-family: var(--font);
            font-size: 0.88rem;
            resize: none;
            min-height: 60px;
            transition: border-color 0.2s;
        }
        .compose-box textarea:focus {
            outline: none;
            border-color: var(--accent);
        }
        .compose-box input[type=text] {
            width: 100%;
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 10px 14px;
            color: var(--text);
            font-family: var(--font);
            font-size: 0.88rem;
            margin-bottom: 8px;
            transition: border-color 0.2s;
        }
        .compose-box input[type=text]:focus {
            outline: none;
            border-color: var(--accent);
        }
        .compose-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 10px;
        }
        .publish-btn {
            background: var(--accent);
            color: #000;
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-family: var(--font);
            font-weight: 700;
            font-size: 0.85rem;
            cursor: pointer;
            transition: opacity 0.2s;
        }
        .publish-btn:hover { opacity: 0.85; }
        .draft-check {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.82rem;
            color: var(--text-dim);
            cursor: pointer;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .layout { grid-template-columns: 1fr; }
            .sidebar { display: none; }
        }
    </style>
</head>
<body>

<!-- Topbar -->
<header class="topbar">
    <div class="logo">feed<span>.</span></div>
    <nav class="nav-links">
        <a href="feed" class="active">New Feed</a>
        <a href="posts">Bài viết</a>
        <a href="users">Người dùng</a>
    </nav>
    <div class="user-pill">
        <div class="avatar">${user.username.substring(0,1).toUpperCase()}</div>
        ${user.username}
    </div>
</header>

<div class="layout">
    <!-- ===== FEED COLUMN ===== -->
    <main>
        <div class="feed-header">
            <h1 class="feed-title">New <em>Feed</em></h1>
            <div class="filter-tabs">
                <button class="filter-tab active" data-filter="smart">Gợi ý</button>
                <button class="filter-tab" data-filter="new">Mới nhất</button>
            </div>
        </div>

        <!-- Compose -->
        <div class="compose-box">
            <form action="posts" method="post">
                <input type="text" name="title" placeholder="Tiêu đề bài viết..." required>
                <textarea name="body" placeholder="Bạn đang nghĩ gì?" rows="2"></textarea>
                <div class="compose-actions">
                    <label class="draft-check">
                        <input type="checkbox" name="status" value="draft"> Lưu nháp
                    </label>
                    <button type="submit" class="publish-btn">Đăng bài</button>
                </div>
            </form>
        </div>

        <!-- Posts container -->
        <div id="posts-container">
            <c:forEach var="p" items="${posts}">
                <div class="post-card" data-post-id="${p.id}">
                    <div class="card-meta">
                        <div class="card-avatar">${p.username.substring(0,1).toUpperCase()}</div>
                        <div>
                            <div class="card-author">@${p.username}</div>
                            <div class="card-time">
                                <fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                        <c:if test="${p.userId == user.id}">
                            <c:choose>
                                <c:when test="${p.status == 'draft'}">
                                    <span class="badge badge-draft">Draft</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-own">Của tôi</span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                    <div class="card-title">${p.title}</div>
                    <div class="card-body">${p.body}</div>
                    <div class="card-actions">
                        <button class="action-btn like-btn ${p.likedByCurrentUser ? 'liked' : ''}"
                                data-post-id="${p.id}">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="${p.likedByCurrentUser ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                            <span class="like-count">${p.likeCount}</span>
                        </button>
                        <button class="action-btn">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                            </svg>
                            <span class="comment-count">${p.commentCount}</span>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Footer loader -->
        <div class="feed-footer" id="feed-footer">
            <div class="spinner" id="spinner"></div>
            <div class="end-msg" id="end-msg">— Hết bài viết —</div>
        </div>
    </main>

    <!-- ===== SIDEBAR ===== -->
    <aside class="sidebar">
        <div class="sidebar-card">
            <div class="sidebar-title">Gợi ý theo dõi</div>
            <c:forEach var="u" items="${suggestedUsers}">
                <div class="suggest-user">
                    <div class="suggest-name">@${u.username}</div>
                    <form action="follow" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="${u.id}">
                        <button type="submit" class="follow-btn">Follow</button>
                    </form>
                </div>
            </c:forEach>
            <c:if test="${empty suggestedUsers}">
                <p style="font-size:0.8rem;color:var(--text-muted)">Không có gợi ý mới</p>
            </c:if>
        </div>

        <div class="sidebar-card">
            <div class="sidebar-title">Thống kê</div>
            <p style="font-size:0.82rem;color:var(--text-dim);line-height:1.8">
                📝 Tổng bài viết của bạn<br>
                ❤️ Lượt like nhận được<br>
                👥 Đang theo dõi
            </p>
        </div>
    </aside>
</div>

<script>
    (function() {
        let currentPage = ${currentPage};
        let hasMore = ${hasMore};
        const currentUserId = ${user.id};
        let loading = false;
        let currentFilter = 'smart';

        const container = document.getElementById('posts-container');
        const spinner   = document.getElementById('spinner');
        const endMsg    = document.getElementById('end-msg');

        const observer = new IntersectionObserver(entries => {
            if (entries[0].isIntersecting && hasMore && !loading) {
                loadMore();
            }
        }, { rootMargin: '200px' });

        observer.observe(document.getElementById('feed-footer'));

        function loadMore() {
            loading = true;
            spinner.classList.add('active');

            const nextPage = currentPage + 1;
            fetch('feed?page=' + nextPage + '&filter=' + currentFilter, {
                headers: { 'X-Requested-With': 'true' }
            })
                .then(r => r.json())
                .then(data => {
                    data.posts.forEach((p, i) => {
                        const card = createPostCard(p);
                        card.style.animationDelay = (i * 0.06) + 's';
                        container.appendChild(card);
                    });
                    currentPage = nextPage;
                    hasMore = data.hasMore;
                    if (!hasMore) {
                        endMsg.classList.add('show');
                        observer.disconnect();
                    }
                })
                .catch(err => console.error('Feed load error:', err))
                .finally(() => {
                    spinner.classList.remove('active');
                    loading = false;
                });
        }

        function createPostCard(p) {
            const card = document.createElement('div');
            card.className = 'post-card';
            card.dataset.postId = p.id;

            const date = new Date(p.createdAt);
            const dateStr = date.toLocaleDateString('vi-VN') + ' ' +
                date.toLocaleTimeString('vi-VN', {hour:'2-digit', minute:'2-digit'});

            const isOwn = p.userId === currentUserId;
            const badgeHtml = isOwn
                ? (p.status === 'draft'
                    ? '<span class="badge badge-draft">Draft</span>'
                    : '<span class="badge badge-own">Của tôi</span>')
                : '';

            card.innerHTML =
                '<div class="card-meta">' +
                '<div class="card-avatar">' + p.username.charAt(0).toUpperCase() + '</div>' +
                '<div>' +
                '<div class="card-author">@' + escHtml(p.username) + '</div>' +
                '<div class="card-time">' + dateStr + '</div>' +
                '</div>' +
                badgeHtml +
                '</div>' +
                '<div class="card-title">' + escHtml(p.title) + '</div>' +
                '<div class="card-body">' + escHtml(p.body || '') + '</div>' +
                '<div class="card-actions">' +
                '<button class="action-btn like-btn ' + (p.likedByCurrentUser ? 'liked' : '') + '" data-post-id="' + p.id + '">' +
                '<svg width="15" height="15" viewBox="0 0 24 24"' +
                ' fill="' + (p.likedByCurrentUser ? 'currentColor' : 'none') + '"' +
                ' stroke="currentColor" stroke-width="2">' +
                '<path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>' +
                '</svg>' +
                '<span class="like-count">' + p.likeCount + '</span>' +
                '</button>' +
                '<button class="action-btn">' +
                '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                '<path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>' +
                '</svg>' +
                '<span class="comment-count">' + p.commentCount + '</span>' +
                '</button>' +
                '</div>';

            card.querySelector('.like-btn').addEventListener('click', handleLike);
            return card;
        }

        document.querySelectorAll('.like-btn').forEach(btn => {
            btn.addEventListener('click', handleLike);
        });

        function handleLike(e) {
            const btn = e.currentTarget;
            const postId = btn.dataset.postId;
            const countEl = btn.querySelector('.like-count');
            const svg = btn.querySelector('svg');

            fetch('feed', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=like&postId=' + postId
            })
                .then(r => r.json())
                .then(data => {
                    if (data.liked) {
                        btn.classList.add('liked');
                        svg.setAttribute('fill', 'currentColor');
                        countEl.textContent = parseInt(countEl.textContent) + 1;
                    } else {
                        btn.classList.remove('liked');
                        svg.setAttribute('fill', 'none');
                        countEl.textContent = Math.max(0, parseInt(countEl.textContent) - 1);
                    }
                });
        }

        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                currentFilter = this.dataset.filter;
                container.innerHTML = '';
                currentPage = -1;
                hasMore = true;
                endMsg.classList.remove('show');
                loadMore();
            });
        });

        function escHtml(str) {
            const d = document.createElement('div');
            d.appendChild(document.createTextNode(str));
            return d.innerHTML;
        }
    })();
</script>
</body>
</html>