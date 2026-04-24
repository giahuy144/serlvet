package model;
import java.sql.Timestamp;

public class Post {
    private int id;
    private String title;
    private String body;
    private int userId;
    private String status;
    private Timestamp createdAt;
    
    public Post(int id, String title, String body, int userId, String status, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.userId = userId;
        this.status = status;
        this.createdAt = createdAt;
    }
    
    // Getters và Setters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public int getUserId() { return userId; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
}