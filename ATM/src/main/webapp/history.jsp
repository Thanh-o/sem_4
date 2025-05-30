<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        body {
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background: linear-gradient(90deg, #1c2526 0%, #2d3839 100%);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            padding: 1rem 0;
        }

        .btn-custom {

            padding: 0.4rem 1.2rem;
            transition: transform 0.3s ease, background 0.3s ease;
        }
        .history-card {
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .table {
            border-radius: 12px;
            overflow: hidden;
            background: #f9fbfc;
        }
        .table thead th {
            background: linear-gradient(90deg, #343a40 0%, #495057 100%);
            color: #fff;
            border: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 15px;
        }
        .table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #e9ecef;
        }
        .table tbody tr:hover {
            background: #e9ecef;

        }
        .transaction-icon {
            font-size: 1.4rem;
            margin-right: 10px;
            animation: fadeIn 0.5s ease-in;
        }
        .alert-dismissible {
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff 0%, #00c4ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
        }
        .load-more-btn {
            background: linear-gradient(90deg, #007bff 0%, #00c4ff 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            color: white;
            transition: all 0.3s ease;
        }
        .load-more-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @media (max-width: 768px) {
            .history-card {
                padding: 15px;
            }
            .table thead th, .table tbody td {
                font-size: 0.9rem;
                padding: 10px;
            }
            .avatar {
                width: 35px;
                height: 35px;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <!-- Navbar Brand -->
        <a class="navbar-brand fw-bold" href="user">
            <i class="fas fa-university me-2"></i> Banking App
        </a>

        <!-- Toggle Button for Mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="ms-auto">
                <form method="get" action="logout" id="logoutForm">
                    <button type="button" class="btn btn-danger btn-custom" id="logoutBtn">
                        <i class="fa fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="history-card p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="text-primary animate__animated animate__fadeIn">
                <i class="fas fa-history me-2"></i> Transaction History for Account ${accountId}
            </h2>
            <div class="d-flex align-items-center">
                <div class="avatar me-2"><%= username.charAt(0) %></div>
                <span class="text-muted">User: <%= username %></span>
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show mt-3">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show mt-3">
                <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <c:choose>
            <c:when test="${empty transactions}">
                <div class="text-center py-4">
                    <p class="text-muted">No transactions found for this account.</p>
                </div>
            </c:when>
            <c:otherwise>
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
                            <tr class="text-center align-middle animate__animated animate__fadeIn">
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
                                    <c:out value="${transaction.recipient != null ? transaction.recipient : 'N/A'}" />
                                </td>
                                <td class="text-muted">
                                    <fmt:formatDate value="${transaction.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="text-center mt-4">
            <button class="load-more-btn">Load More</button>
        </div>
    </div>
</div>
<div class="modal fade" id="confirmLogoutModal" tabindex="-1" aria-labelledby="confirmLogoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 15px; background: #fff; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);">
            <div class="modal-header" style="background: linear-gradient(90deg, #dc3545, #c82333); color: white; border-radius: 15px 15px 0 0;">
                <h5 class="modal-title" id="confirmLogoutModalLabel">
                    <i class="fas fa-sign-out-alt me-2"></i> Confirm Logout
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to log out of your account?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Cancel
                </button>
                <button type="button" class="btn btn-danger" id="confirmLogoutBtn">
                    <i class="fas fa-check me-1"></i> Logout
                </button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', (event) => {
        var toastElList = [].slice.call(document.querySelectorAll('.toast'));
        var toastList = toastElList.map(function(toastEl) {
            return new bootstrap.Toast(toastEl);
        });
        toastList.forEach(toast => toast.show());

        // Xử lý nút Logout
        const logoutBtn = document.getElementById('logoutBtn');
        const confirmLogoutModal = new bootstrap.Modal(document.getElementById('confirmLogoutModal'));
        const confirmLogoutBtn = document.getElementById('confirmLogoutBtn');

        logoutBtn.addEventListener('click', function() {
            confirmLogoutModal.show();
        });

        confirmLogoutBtn.addEventListener('click', function() {
            confirmLogoutModal.hide();
            document.getElementById('logoutForm').submit(); // Gửi form logout
        });
    });
</script>
<script>
    // Optional: Add interactivity for "Load More" button
    document.querySelector('.load-more-btn').addEventListener('click', function() {
        alert('Loading more transactions... (This is a placeholder)');
    });
</script>
</body>
</html>