<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Exam, dao.ExamDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    ExamDAO examDAO = new ExamDAO();
    List<Exam> exams = examDAO.getAllExams();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Exam Portal (Admin)</a>
            <div class="navbar-nav ms-auto">
                <span class="nav-link text-light">Welcome, <%= user.getName() %></span>
                <a class="nav-link btn btn-danger btn-sm text-white px-3 ms-2" href="logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Dashboard</h2>
            <div>
                <a href="create_exam.jsp" class="btn btn-primary">Create New Exam</a>
                <a href="view_results.jsp" class="btn btn-info text-white">View Student Results</a>
            </div>
        </div>

        <h4>Existing Exams</h4>
        <div class="row mt-3">
            <% if (exams.isEmpty()) { %>
                <div class="col-12"><p>No exams created yet.</p></div>
            <% } else {
                for (Exam exam : exams) { %>
                <div class="col-md-4 mb-3">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title"><%= exam.getTitle() %></h5>
                            <p class="card-text">Duration: <%= exam.getDuration() %> mins</p>
                            <a href="add_question.jsp?examId=<%= exam.getId() %>" class="btn btn-sm btn-outline-success">Add Questions</a>
                        </div>
                    </div>
                </div>
            <% } } %>
        </div>
    </div>
</body>
</html>
