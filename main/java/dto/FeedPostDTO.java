package dto;

import java.sql.Timestamp;

public class FeedPostDTO {
    private int id;
    private String title;
    private String body;
    private int userId;
    private  String username;
    private String status;
    private Timestamp createdAt;
    private int likeCount;
    private int commentCount;
    private boolean likedByCurrentUser;

    private double priorityScore;

    public FeedPostDTO(int id, String title, String body, int userId,
                       String username, String status, Timestamp createdaAt,
                       int likeCount, int commentCount, boolean likedByCurrentUser) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.userId = userId;
        this.username = username;
        this.status = status;
        this.createdAt = createdaAt;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
        this.likedByCurrentUser = this.likedByCurrentUser;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getBody() { return body; }
    public int getUserId() { return userId; }
    public String getUsername() { return username; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public int getLikeCount() { return likeCount; }
    public int getCommentCount() { return commentCount; }
    public boolean isLikedByCurrentUser() { return likedByCurrentUser; }
    public double getPriorityScore() { return priorityScore; }
    public void setPriorityScore(double score) { this.priorityScore = score; }

}

