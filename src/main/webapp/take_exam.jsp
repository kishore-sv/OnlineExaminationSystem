<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"student".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    int examId = Integer.parseInt(request.getParameter("examId"));
    ExamDAO examDAO = new ExamDAO();
    Exam exam = examDAO.getExamById(examId);
    
    QuestionDAO questionDAO = new QuestionDAO();
    List<Question> questions = questionDAO.getQuestionsByExamId(examId);
    
    if (questions.isEmpty()) {
        response.sendRedirect("student_dashboard.jsp?error=Exam has no questions");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Attempt Exam - <%= exam.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .sticky-timer { position: sticky; top: 10px; z-index: 1000; }
        .question-card { margin-bottom: 20px; transition: transform 0.2s; }
        .question-card:hover { transform: scale(1.01); }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><%= exam.getTitle() %></h3>
                </div>

                <form id="examForm" action="student" method="post">
                    <input type="hidden" name="action" value="submitExam">
                    <input type="hidden" name="examId" value="<%= examId %>">

                    <% int count = 1; for(Question q : questions) { %>
                        <div class="card shadow-sm question-card border-0">
                            <div class="card-body">
                                <h5 class="card-title text-primary">Question <%= count++ %></h5>
                                <p class="fs-5 mb-4"><%= q.getQuestionText() %></p>
                                
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="q<%= q.getId() %>" value="1" id="q<%= q.getId() %>a">
                                    <label class="form-check-label w-100 p-2 border rounded" for="q<%= q.getId() %>a">
                                        <%= q.getOption1() %>
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="q<%= q.getId() %>" value="2" id="q<%= q.getId() %>b">
                                    <label class="form-check-label w-100 p-2 border rounded" for="q<%= q.getId() %>b">
                                        <%= q.getOption2() %>
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="q<%= q.getId() %>" value="3" id="q<%= q.getId() %>c">
                                    <label class="form-check-label w-100 p-2 border rounded" for="q<%= q.getId() %>c">
                                        <%= q.getOption3() %>
                                    </label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="radio" name="q<%= q.getId() %>" value="4" id="q<%= q.getId() %>d">
                                    <label class="form-check-label w-100 p-2 border rounded" for="q<%= q.getId() %>d">
                                        <%= q.getOption4() %>
                                    </label>
                                </div>
                            </div>
                        </div>
                    <% } %>

                    <div class="text-center mb-5">
                        <button type="submit" class="btn btn-success btn-lg px-5 shadow">Finish & Submit Exam</button>
                    </div>
                </form>
            </div>

            <div class="col-lg-4">
                <div class="card sticky-timer shadow border-primary border-3">
                    <div class="card-body text-center">
                        <h4 class="card-title mb-3">Time Remaining</h4>
                        <div id="timer" class="display-4 fw-bold text-danger">00:00</div>
                        <hr>
                        <p class="text-muted small">The exam will automatically submit when the timer hits zero.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Set duration in seconds
        let timeLeft = <%= (exam != null ? exam.getDuration() : 0) %> * 60;
        const timerDisplay = document.getElementById('timer');
        const examForm = document.getElementById('examForm');

        function updateTimer() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;

            timerDisplay.textContent = 
                (minutes < 10 ? '0' : '') + minutes + ':' + 
                (seconds < 10 ? '0' : '') + seconds;

            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                alert("Time is up! Your exam will be submitted automatically.");
                examForm.submit();
            }
            timeLeft--;
        }

        const timerInterval = setInterval(updateTimer, 1000);
        updateTimer(); // Initial call
    </script>
</body>
</html>
