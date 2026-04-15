<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
    int examId = Integer.parseInt(request.getParameter("examId"));
    ExamDAO examDAO = new ExamDAO();
    Exam exam = examDAO.getExamById(examId);
    
    QuestionDAO questionDAO = new QuestionDAO();
    List<Question> questions = questionDAO.getQuestionsByExamId(examId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Questions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="admin_dashboard.jsp">Dashboard</a></li>
                <li class="breadcrumb-item active text-truncate" style="max-width: 200px;"><%= exam.getTitle() %></li>
            </ol>
        </nav>

        <div class="row">
            <div class="col-md-5">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-dark text-white">Add New Question</div>
                    <div class="card-body">
                        <form action="admin" method="post">
                            <input type="hidden" name="action" value="addQuestion">
                            <input type="hidden" name="examId" value="<%= examId %>">
                            <div class="mb-2">
                                <label class="form-label">Question Text</label>
                                <textarea name="question" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Option 1</label>
                                <input type="text" name="option1" class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Option 2</label>
                                <input type="text" name="option2" class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Option 3</label>
                                <input type="text" name="option3" class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Option 4</label>
                                <input type="text" name="option4" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Correct Option (1-4)</label>
                                <select name="correct" class="form-select" required>
                                    <option value="1">Option 1</option>
                                    <option value="2">Option 2</option>
                                    <option value="3">Option 3</option>
                                    <option value="4">Option 4</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Save Question</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-7">
                <h4>Questions in this Exam (<%= questions.size() %>)</h4>
                <% int count = 1; for(Question q : questions) { %>
                    <div class="card mb-3 border-0 shadow-sm">
                        <div class="card-body">
                            <p class="fw-bold"><%= count++ %>. <%= q.getQuestionText() %></p>
                            <ul class="list-group list-group-flush mb-2">
                                <li class="list-group-item py-1 small <%= q.getCorrectAnswer()==1 ? "text-success fw-bold":"" %>">A: <%= q.getOption1() %></li>
                                <li class="list-group-item py-1 small <%= q.getCorrectAnswer()==2 ? "text-success fw-bold":"" %>">B: <%= q.getOption2() %></li>
                                <li class="list-group-item py-1 small <%= q.getCorrectAnswer()==3 ? "text-success fw-bold":"" %>">C: <%= q.getOption3() %></li>
                                <li class="list-group-item py-1 small <%= q.getCorrectAnswer()==4 ? "text-success fw-bold":"" %>">D: <%= q.getOption4() %></li>
                            </ul>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
