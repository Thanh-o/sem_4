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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .history-card {
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .table {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background: #212529;
            color: white;
            border: none;
        }

        .table tbody tr {
            transition: background 0.2s ease;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
        }

        .transaction-icon {
            font-size: 1.2rem;
            margin-right: 8px;
        }

        .alert-dismissible {
            border-radius: 10px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #007bff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="user">🏠 Home</a>
        <div class="ms-auto">
            <form method="get" action="logout">
                <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                    <i class="fa fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="history-card p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary">
                <i class="fas fa-history me-2"></i>Transaction History
            </h2>
            <span class="text-muted">User: <%= username %></span>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show mt-3">
                <i class="bi bi-check-circle-fill"></i>  ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show mt-3">
                <i class="bi bi-exclamation-triangle-fill"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr class="text-center">
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Recipient</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="transaction" items="${transactions}">
                    <tr class="text-center align-middle">
                        <td>
                            <c:choose>
                                <c:when test="${transaction.type == 'TRANSFER'}">
                                        <span class="text-primary">
                                            <i class="fas fa-exchange-alt transaction-icon"></i>
                                            Transfer
                                        </span>
                                </c:when>
                                <c:when test="${transaction.type == 'WITHDRAW'}">
                                        <span class="text-warning">
                                            <i class="fas fa-money-bill-wave transaction-icon"></i>
                                            Withdraw
                                        </span>
                                </c:when>
                                <c:otherwise>
                                        <span class="text-success">
                                            <i class="fas fa-arrow-down transaction-icon"></i>
                                            Deposit
                                        </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="fw-bold text-success">
                            $${transaction.amount}
                        </td>
                        <td>
                            <c:out value="${transaction.recipient}" default="N/A" />
                        </td>
                        <td class="text-muted">
                                ${transaction.createdAt}
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>