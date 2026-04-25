package dao;

import dto.FeedPostDTO;
import model.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedDAO {

    private static final int PAGE_SIZE = 5;

    public List<FeedPostDTO> getFeedPaged(int currentUserId, int page) {
        List<FeedPostDTO> posts = new ArrayList<>();
        int offset = page * PAGE_SIZE;

        String sql =
                "SELECT " +
                        "    p.id, p.title, p.body, p.user_id, u.username, p.status, p.created_at, " +
                        "    COUNT(DISTINCT l.id)       AS like_count, " +
                        "    COUNT(DISTINCT c.id)       AS comment_count, " +
                        "    MAX(CASE WHEN l2.user_id = ? THEN 1 ELSE 0 END) AS liked_by_me, " +
                        // interaction_score = bao nhiêu lần current user đã like/comment bài của author này
                        "    COALESCE(uis.interaction_score, 0) AS interaction_score " +
                        "FROM posts p " +
                        "JOIN users u ON p.user_id = u.id " +
                        "LEFT JOIN likes     l  ON l.post_id  = p.id " +
                        "LEFT JOIN likes     l2 ON l2.post_id = p.id AND l2.user_id = ? " +
                        "LEFT JOIN comments  c  ON c.post_id  = p.id " +
                        // Sub-query: đếm tương tác của currentUser với từng author
                        "LEFT JOIN ( " +
                        "    SELECT author_id, SUM(cnt) AS interaction_score " +
                        "    FROM ( " +
                        "        SELECT p2.user_id AS author_id, COUNT(*) AS cnt " +
                        "        FROM likes lx JOIN posts p2 ON lx.post_id = p2.id " +
                        "        WHERE lx.user_id = ? GROUP BY p2.user_id " +
                        "        UNION ALL " +
                        "        SELECT p3.user_id AS author_id, COUNT(*) AS cnt " +
                        "        FROM comments cx JOIN posts p3 ON cx.post_id = p3.id " +
                        "        WHERE cx.user_id = ? GROUP BY p3.user_id " +
                        "    ) t GROUP BY author_id " +
                        ") uis ON uis.author_id = p.user_id " +
                        "WHERE " +
                        "    p.user_id = ? " +                     // bài của chính mình
                        "    OR ( p.status = 'published' AND p.user_id IN ( " +
                        "        SELECT followed_user_id FROM follows WHERE following_user_id = ? " +
                        "    )) " +
                        "GROUP BY p.id, p.title, p.body, p.user_id, u.username, p.status, p.created_at, uis.interaction_score " +
                        "ORDER BY " +
                        // Thuật toán sắp xếp ưu tiên
                        "    (COALESCE(uis.interaction_score, 0) * 3) " +
                        "  + (COUNT(DISTINCT l.id) + COUNT(DISTINCT c.id) * 1.5) " +
                        "  + (10.0 / (TIMESTAMPDIFF(HOUR, p.created_at, NOW()) + 2)) " +
                        "  DESC " +
                        "LIMIT ? OFFSET ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, currentUserId);  // liked_by_me check
            stmt.setInt(2, currentUserId);  // liked_by_me join
            stmt.setInt(3, currentUserId);  // interaction sub-query likes
            stmt.setInt(4, currentUserId);  // interaction sub-query comments
            stmt.setInt(5, currentUserId);  // own posts
            stmt.setInt(6, currentUserId);  // followed posts
            stmt.setInt(7, PAGE_SIZE);
            stmt.setInt(8, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FeedPostDTO dto = new FeedPostDTO(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("body"),
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("status"),
                            rs.getTimestamp("created_at"),
                            rs.getInt("like_count"),
                            rs.getInt("comment_count"),
                            rs.getInt("liked_by_me") == 1
                    );
                    dto.setPriorityScore(
                            rs.getDouble("interaction_score") * 3
                                    + rs.getInt("like_count")
                                    + rs.getInt("comment_count") * 1.5
                    );
                    posts.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public boolean hasMore(int currentUserId, int page) {
        // Kiểm tra còn bài không (để frontend biết có load tiếp không)
        int offset = (page + 1) * PAGE_SIZE;
        String sql =
                "SELECT COUNT(*) FROM posts p " +
                        "WHERE p.user_id = ? OR (p.status='published' AND p.user_id IN (" +
                        "  SELECT followed_user_id FROM follows WHERE following_user_id=?)) " +
                        "LIMIT 1 OFFSET ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, currentUserId);
            stmt.setInt(2, currentUserId);
            stmt.setInt(3, offset);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /** Like hoặc unlike bài viết (toggle) */
    public boolean toggleLike(int userId, int postId) {
        // Thử delete trước, nếu không có thì insert
        String deleteSql = "DELETE FROM likes WHERE user_id=? AND post_id=?";
        String insertSql = "INSERT INTO likes(user_id, post_id) VALUES(?,?)";
        try (Connection conn = Database.getConnection()) {
            PreparedStatement del = conn.prepareStatement(deleteSql);
            del.setInt(1, userId);
            del.setInt(2, postId);
            int deleted = del.executeUpdate();
            if (deleted == 0) {
                // Chưa like → like
                PreparedStatement ins = conn.prepareStatement(insertSql);
                ins.setInt(1, userId);
                ins.setInt(2, postId);
                ins.executeUpdate();
                return true; // now liked
            }
            return false; // now unliked
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
