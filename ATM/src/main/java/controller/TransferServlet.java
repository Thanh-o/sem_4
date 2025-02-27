package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

import java.io.IOException;

@WebServlet("/transfer")
public class TransferServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer senderId = (Integer) session.getAttribute("user_id");
        int recipientId = Integer.parseInt(request.getParameter("recipient"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        Account accountDAO = new Account();
        boolean success = accountDAO.transfer(senderId, recipientId, amount);

        if (success) {
            session.setAttribute("message", "Transfer successful");
            response.sendRedirect("history");

        } else {
            session.setAttribute("error", "Transfer failed");
            response.sendRedirect("transfer.jsp");
        }
    }
}
