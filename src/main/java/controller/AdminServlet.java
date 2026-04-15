package controller;

import dao.ExamDAO;
import dao.QuestionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Exam;
import model.Question;
import model.User;

import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private ExamDAO examDAO = new ExamDAO();
    private QuestionDAO questionDAO = new QuestionDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("createExam".equals(action)) {
            String title = request.getParameter("title");
            int duration = Integer.parseInt(request.getParameter("duration"));
            Exam exam = new Exam();
            exam.setTitle(title);
            exam.setDuration(duration);
            exam.setCreatedBy(user.getId());
            int examId = examDAO.createExam(exam);
            if (examId > 0) {
                response.sendRedirect("add_question.jsp?examId=" + examId);
            } else {
                response.sendRedirect("admin_dashboard.jsp?error=Failed to create exam");
            }
        } else if ("addQuestion".equals(action)) {
            int examId = Integer.parseInt(request.getParameter("examId"));
            Question q = new Question();
            q.setExamId(examId);
            q.setQuestionText(request.getParameter("question"));
            q.setOption1(request.getParameter("option1"));
            q.setOption2(request.getParameter("option2"));
            q.setOption3(request.getParameter("option3"));
            q.setOption4(request.getParameter("option4"));
            q.setCorrectAnswer(Integer.parseInt(request.getParameter("correct")));

            if (questionDAO.addQuestion(q)) {
                response.sendRedirect("add_question.jsp?examId=" + examId + "&msg=Question added");
            } else {
                response.sendRedirect("add_question.jsp?examId=" + examId + "&error=Failed to add question");
            }
        }
    }
}
