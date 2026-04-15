<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    ResultDAO resultDAO = new ResultDAO();
    List<Result> results = resultDAO.getAllResults();
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Student Results</h2>
            <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-hover mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Student Name</th>
                            <th>Exam Title</th>
                            <th>Score</th>
                            <th>Date Submitted</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (results.isEmpty()) { %>
                            <tr><td colspan="4" class="text-center">No results found.</td></tr>
                        <% } else {
                            for (Result r : results) { %>
                            <tr>
                                <td><%= r.getUserName() %></td>
                                <td><%= r.getExamTitle() %></td>
                                <td><span class="badge bg-success fs-6"><%= r.getScore() %></span></td>
                                <td><%= r.getSubmittedAt() %></td>
                            </tr>
                        <% } } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
