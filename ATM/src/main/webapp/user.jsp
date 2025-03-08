<%@ page import="util.JwtUtil" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        .dashboard-card {
            border: none;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .btn-action {
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            background: linear-gradient(90deg, #007bff 0%, #00c4ff 100%);
            border: none;
            color: white;
        }
        .btn-action:hover {
            transform: scale(1.1);
            box-shadow: 0 5px 20px rgba(0, 123, 255, 0.4);
            color: white;
        }
        .btn-warning {
            background: linear-gradient(90deg, #ff9800 0%, #ffca28 100%);
        }
        .btn-info {
            background: linear-gradient(90deg, #00bcd4 0%, #26c6da 100%);
        }
        .balance-display {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 25px;
            margin: 20px 0;
            box-shadow: inset 0 2px 10px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.5s ease-in;
        }
        .avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff 0%, #00c4ff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
            margin-bottom: 15px;
        }
        .refresh-btn {
            font-size: 0.9rem;
            padding: 5px 15px;
            border-radius: 20px;
            background: #6c757d;
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .refresh-btn:hover {
            background: #5a6268;
            transform: scale(1.05);
        }
        .switch-btn {
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 500;
            background: #6c757d;
            color: white;
            border: none;
            transition: all 0.3s ease;
        }
        .switch-btn:hover {
            background: #5a6268;
            transform: scale(1.05);
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @media (max-width: 768px) {
            .dashboard-card { padding: 20px; }
            .btn-action { padding: 10px 20px; font-size: 0.9rem; }
            .avatar { width: 50px; height: 50px; font-size: 1.2rem; }
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
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="dashboard-card">
                <div class="text-center">
                    <div class="avatar mx-auto"><%= username.charAt(0) %></div>
                    <h2 class="text-primary mb-4 animate__animated animate__fadeIn">
                        👋 Welcome, <%= username %>!
                    </h2>

                    <div class="balance-display">
                        <c:choose>
                            <c:when test="${empty accounts}">
                                <p class="text-muted">No accounts found.</p>
                            </c:when>
                            <c:otherwise>
                                <h5>Account ID: ${accounts[currentIndex].id}</h5>
                                <h3 class="text-success fw-bold">$${accounts[currentIndex].balance}</h3>
                                <div class="d-flex justify-content-center gap-3 mt-3">
                                    <c:if test="${currentIndex > 0}">
                                        <a href="user?currentIndex=${currentIndex - 1}" class="switch-btn">
                                            <i class="fas fa-arrow-left me-1"></i> Previous
                                        </a>
                                    </c:if>
                                    <c:if test="${currentIndex < accounts.size() - 1}">
                                        <a href="user?currentIndex=${currentIndex + 1}" class="switch-btn">
                                            Next <i class="fas fa-arrow-right me-1"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <button class="refresh-btn mt-3" onclick="location.reload();">
                            <i class="fas fa-sync-alt me-1"></i> Refresh
                        </button>
                    </div>

                    <c:if test="${not empty accounts}">
                        <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                            <a href="transfer.jsp?accountId=${accounts[currentIndex].id}" class="btn btn-primary btn-action">
                                <i class="fas fa-exchange-alt me-2"></i> Transfer
                            </a>
                            <a href="withdraw.jsp?accountId=${accounts[currentIndex].id}" class="btn btn-warning btn-action">
                                <i class="fas fa-money-bill-wave me-2"></i> Withdraw
                            </a>
                            <a href="history?accountId=${accounts[currentIndex].id}" class="btn btn-info btn-action">
                                <i class="fas fa-history me-2"></i> History
                            </a>
                        </div>
                    </c:if>

                    <div class="mt-4 text-muted">
                        <small>Last updated: <%= new java.util.Date() %></small>
                    </div>
                </div>
            </div>
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
</body>
</html>