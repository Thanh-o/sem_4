package com.example.librarysystem.controller;

import com.example.librarysystem.dao.LoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/loanBook")
public class LoanBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long userId = Long.parseLong(request.getParameter("userId"));
        Long bookId = Long.parseLong(request.getParameter("bookId"));
        Date returnDate = Date.valueOf(request.getParameter("returnDate"));

        new LoanDAO().loanBook(userId, bookId, returnDate);
        response.getWriter().write("Book loaned successfully!");
    }
}

