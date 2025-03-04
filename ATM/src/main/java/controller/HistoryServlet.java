package controller;

import model.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy accountId từ request parameter
        String accountIdParam = request.getParameter("accountId");
        Integer accountId = null;
        if (accountIdParam != null && !accountIdParam.isEmpty()) {
            try {
                accountId = Integer.parseInt(accountIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Kiểm tra xem accountId có hợp lệ không
        if (accountId == null) {
            response.sendRedirect("user");
            return;
        }

        // Kiểm tra userId để đảm bảo người dùng đã đăng nhập
        Integer userId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
        }

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy danh sách giao dịch dựa trên accountId
        Transaction transactionDAO = new Transaction();
        List<Transaction> transactions = transactionDAO.getTransactions(accountId); // Sử dụng phương thức hiện có

        request.setAttribute("transactions", transactions);
        request.setAttribute("accountId", accountId); // Gửi accountId để hiển thị trong JSP
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}