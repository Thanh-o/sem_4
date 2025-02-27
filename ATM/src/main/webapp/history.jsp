<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="util.JwtUtil" %>
<%
    String username = null;
    String token = null;

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwt_token".equals(cookie.getName())) {
                token = cookie.getValue();
                username = JwtUtil.validateToken(token);
            }
        }
    }

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Transaction History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user">👋Welcome, <%= username %>!</a>
        <div class="ms-auto">
            <form method="get" action="logout">
                <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                    <i class="fa fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <h2 class="text-primary text-center">
                <i class="fas fa-history"></i> Transaction History for <%= username %>
            </h2>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success mt-3 fade show">${message}</div>
        <% session.removeAttribute("message"); %>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3 fade show">${error}</div>
        <% session.removeAttribute("error"); %>
    </c:if>

    <div class="table-responsive mt-3">
        <table class="table table-hover table-bordered">
            <thead class="table-dark text-center">
            <tr>
                <th>Type</th>
                <th>Amount</th>
                <th>Recipient</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="transaction" items="${transactions}">
                <tr class="text-center">
                    <td>
                        <c:choose>
                            <c:when test="${transaction.type == 'TRANSFER'}">
                                <span class="text-primary"><i class="fas fa-exchange-alt"></i> ${transaction.type}</span>
                            </c:when>
                            <c:when test="${transaction.type == 'WITHDRAW'}">
                                <span class="text-warning">  <i class="fas fa-money-bill-wave"></i> ${transaction.type}</span>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-arrow-down"></i> $DEPOSIT
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td><strong>${transaction.amount}</strong> USD</td>
                    <td>${transaction.recipient}</td>
                    <td>${transaction.createdAt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
