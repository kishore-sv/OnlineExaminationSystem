<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Exam, model.Result, dao.ExamDAO, dao.ResultDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    ExamDAO examDAO = new ExamDAO();
    ResultDAO resultDAO = new ResultDAO();
    List<Exam> availableExams = examDAO.getAllExams();
    List<Result> userResults = resultDAO.getResultsByUserId(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">Exam Portal (Student)</a>
            <div class="navbar-nav ms-auto">
                <span class="nav-link text-white">Welcome, <%= user.getName() %></span>
                <a class="nav-link btn btn-danger btn-sm text-white px-3 ms-2" href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <h4>Available Exams</h4>
                <div class="row mt-3">
                    <% if (availableExams.isEmpty()) { %>
                        <div class="col-12"><p>No exams available right now.</p></div>
                    <% } else {
                        for (Exam exam : availableExams) { %>
                        <div class="col-md-6 mb-3">
                            <div class="card shadow-sm border-0 border-start border-4 border-primary">
                                <div class="card-body">
                                    <h5 class="card-title"><%= exam.getTitle() %></h5>
                                    <p class="card-text mb-1"><strong>Duration:</strong> <%= exam.getDuration() %> mins</p>
                                    <a href="take_exam.jsp?examId=<%= exam.getId() %>" class="btn btn-primary mt-2">Start Exam</a>
                                </div>
                            </div>
                        </div>
                    <% } } %>
                </div>
            </div>

            <div class="col-md-4">
                <h4>My Past Results</h4>
                <div class="card shadow-sm mt-3">
                    <ul class="list-group list-group-flush">
                        <% if (userResults.isEmpty()) { %>
                            <li class="list-group-item text-muted">No attempts yet.</li>
                        <% } else {
                            for (Result r : userResults) { %>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="fw-bold"><%= r.getExamTitle() %></div>
                                    <small class="text-muted"><%= r.getSubmittedAt() %></small>
                                </div>
                                <span class="badge bg-success rounded-pill fw-normal">Score: <%= r.getScore() %></span>
                            </li>
                        <% } } %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
