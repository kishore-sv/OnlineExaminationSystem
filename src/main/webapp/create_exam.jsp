<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Exam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">Create New Exam</h4>
                    </div>
                    <div class="card-body">
                        <form action="admin" method="post">
                            <input type="hidden" name="action" value="createExam">
                            <div class="mb-3">
                                <label class="form-label">Exam Title</label>
                                <input type="text" name="title" class="form-control" placeholder="e.g. Core Java Basics" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Duration (Minutes)</label>
                                <input type="number" name="duration" class="form-control" placeholder="e.g. 30" required>
                            </div>
                            <div class="d-flex justify-content-between">
                                <a href="admin_dashboard.jsp" class="btn btn-secondary">Back</a>
                                <button type="submit" class="btn btn-success">Save & Add Questions</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
