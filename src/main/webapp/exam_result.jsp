<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    String score = request.getParameter("score");
    String total = request.getParameter("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .result-card { max-width: 500px; margin: 100px auto; }
        .score-circle { 
            width: 150px; height: 150px; border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; 
            margin: 20px auto; border: 8px solid #198754;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="card result-card shadow-lg text-center border-0">
            <div class="card-header bg-success text-white py-3">
                <h4 class="mb-0">Congratulations!</h4>
            </div>
            <div class="card-body py-5">
                <p class="fs-4">You have successfully completed the examination.</p>
                <div class="score-circle">
                    <div>
                        <span class="display-4 fw-bold"><%= score %></span><br>
                        <span class="text-muted">/ <%= total %></span>
                    </div>
                </div>
                <h5 class="text-success fw-bold">Your Score: <%= (int)(Double.parseDouble(score)/Double.parseDouble(total) * 100) %>%</h5>
                <hr class="my-4">
                <a href="student_dashboard.jsp" class="btn btn-primary btn-lg">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
