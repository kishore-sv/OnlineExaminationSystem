package controller;

import dao.QuestionDAO;
import dao.ResultDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Question;
import model.Result;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    private QuestionDAO questionDAO = new QuestionDAO();
    private ResultDAO resultDAO = new ResultDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"student".equals(user.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("submitExam".equals(action)) {
            int examId = Integer.parseInt(request.getParameter("examId"));
            List<Question> questions = questionDAO.getQuestionsByExamId(examId);
            int score = 0;

            for (Question q : questions) {
                String selectedOption = request.getParameter("q" + q.getId());
                if (selectedOption != null && Integer.parseInt(selectedOption) == q.getCorrectAnswer()) {
                    score++;
                }
            }

            Result result = new Result();
            result.setExamId(examId);
            result.setUserId(user.getId());
            result.setScore(score);

            if (resultDAO.saveResult(result)) {
                response.sendRedirect("exam_result.jsp?score=" + score + "&total=" + questions.size());
            } else {
                response.sendRedirect("student_dashboard.jsp?error=Failed to submit exam");
            }
        }
    }
}
