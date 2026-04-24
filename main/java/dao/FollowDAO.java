package dao;
import model.*;
import java.sql.*;
import java.util.*;

public class FollowDAO {
    public boolean follow(int followingUserId, int followedUserId) {
        String sql = "INSERT INTO follows(following_user_id, followed_user_id) VALUES(?,?)";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, followingUserId);
            stmt.setInt(2, followedUserId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Integer> getFollowingList(int userId) {
        List<Integer> following = new ArrayList<>();
        String sql = "SELECT followed_user_id FROM follows WHERE following_user_id=?";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                following.add(rs.getInt("followed_user_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return following;
    }
}