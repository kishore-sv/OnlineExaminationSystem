package dao;

import db.DBConnection;
import model.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {
    public boolean saveResult(Result result) {
        String sql = "INSERT INTO results (exam_id, user_id, score) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, result.getExamId());
            ps.setInt(2, result.getUserId());
            ps.setInt(3, result.getScore());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Result> getAllResults() {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT r.*, e.title as exam_title, u.name as user_name FROM results r " +
                     "JOIN exams e ON r.exam_id = e.id " +
                     "JOIN users u ON r.user_id = u.id ORDER BY r.submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Result r = new Result();
                r.setId(rs.getInt("id"));
                r.setExamId(rs.getInt("exam_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setScore(rs.getInt("score"));
                r.setSubmittedAt(rs.getTimestamp("submitted_at"));
                r.setExamTitle(rs.getString("exam_title"));
                r.setUserName(rs.getString("user_name"));
                results.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    public List<Result> getResultsByUserId(int userId) {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT r.*, e.title as exam_title FROM results r " +
                     "JOIN exams e ON r.exam_id = e.id WHERE r.user_id = ? ORDER BY r.submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Result r = new Result();
                r.setId(rs.getInt("id"));
                r.setExamId(rs.getInt("exam_id"));
                r.setScore(rs.getInt("score"));
                r.setSubmittedAt(rs.getTimestamp("submitted_at"));
                r.setExamTitle(rs.getString("exam_title"));
                results.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }
}
