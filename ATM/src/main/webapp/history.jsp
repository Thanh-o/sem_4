<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionUser = request.getSession(false);
    if (request.getParameter("action") != null && request.getParameter("action").equals("logout")) {
        if (sessionUser != null) {
            sessionUser.invalidate();
        }
        response.sendRedirect("login.jsp");
        return;
    }
    HttpSession sessionObj = request.getSession(false);
    String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;
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
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user">🏠 Home</a>
        <div class="ms-auto">
            <a class="btn btn-danger" href="user.jsp?action=logout">🚪 Logout</a>
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
                            <c:when test="${transaction.type == 'Deposit'}">
                                <span class="text-success"><i class="fas fa-arrow-down"></i> Deposit</span>
                            </c:when>
                            <c:when test="${transaction.type == 'Withdrawal'}">
                                <span class="text-danger"><i class="fas fa-arrow-up"></i> Withdrawal</span>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-exchange-alt"></i> ${transaction.type}
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
