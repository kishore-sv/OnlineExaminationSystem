package model;

import java.sql.Timestamp;

public class Result {
    private int id;
    private int examId;
    private int userId;
    private int score;
    private Timestamp submittedAt;
    
    // Additional fields for display
    private String examTitle;
    private String userName;

    public Result() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }
    public String getExamTitle() { return examTitle; }
    public void setExamTitle(String examTitle) { this.examTitle = examTitle; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}
