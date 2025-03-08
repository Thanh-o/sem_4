package com.example.librarysystem.controller;

import com.example.librarysystem.dao.BookDAO;
import com.example.librarysystem.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        Book book = new Book(title, author);
        new BookDAO().addBook(book);

        response.getWriter().write("Book added successfully!");
    }
}

