<%@ page import="util.JwtUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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

    // Lấy accountId từ request parameter
    String accountId = request.getParameter("accountId");
    if (accountId == null) {
        response.sendRedirect("user");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Funds</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
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

        .nav-link {
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s ease, transform 0.3s ease;
        }
        .btn-custom {

            padding: 0.4rem 1.2rem;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .custom-card {
            max-width: 550px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .custom-btn {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            background: linear-gradient(90deg, #007bff, #0056b3);
            border: none;
            transition: opacity 0.3s ease;
        }
        .custom-btn:hover {
            opacity: 0.9;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px;
        }
        .form-label {
            font-weight: 500;
        }
        .alert {
            border-radius: 8px;
        }
        .account-info {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
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
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link" href="history?accountId=<%= accountId %>">
                        <i class="fas fa-history me-1"></i> Transaction History
                    </a>
                </li>
            </ul>

            <div class="ms-auto">
                <form method="get" action="logout">
                    <button type="submit" class="btn btn-danger btn-custom" onclick="return confirm('Are you sure you want to logout?');">
                        <i class="fa fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card custom-card">
        <div class="card-body">
            <h2 class="text-center text-primary mb-4">
                <i class="fas fa-exchange-alt me-2"></i> Transfer Funds
            </h2>
            <p class="text-muted text-center mb-4">Send money securely and quickly</p>

            <!-- Hiển thị thông tin account gửi -->
            <div class="account-info text-center">
                <h6 class="text-muted mb-2">From Account</h6>
                <h5>Account ID: <%= accountId %></h5>
            </div>

            <form action="transfer" method="post" onsubmit="return validateForm()">
                <!-- Trường ẩn chứa senderAccountId -->
                <input type="hidden" name="senderAccountId" value="<%= accountId %>">

                <div class="mb-4">
                    <label class="form-label"><i class="fas fa-user me-1"></i> Recipient Account ID</label>
                    <input type="number" name="recipientAccountId" class="form-control" min="1" required placeholder="Enter recipient account ID">
                </div>

                <div class="mb-4">
                    <label class="form-label"><i class="fas fa-dollar-sign me-1"></i> Amount to Transfer</label>
                    <input type="number" name="amount" class="form-control" step="0.01" min="1" required placeholder="Enter amount (e.g., 50.00)">
                </div>

                <button type="submit" class="btn btn-primary custom-btn">
                    <i class="fas fa-paper-plane me-2"></i> Send Now
                </button>
            </form>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mt-4">
                    <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% session.removeAttribute("error"); %>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validateForm() {
        const recipient = parseFloat(document.querySelector('input[name="recipientAccountId"]').value);
        const amount = parseFloat(document.querySelector('input[name="amount"]').value);
        const senderAccountId = document.querySelector('input[name="senderAccountId"]').value;

        if (recipient <= 0) {
            alert('Please enter a valid recipient account ID.');
            return false;
        }
        if (recipient === senderAccountId) {
            alert('Recipient account ID cannot be the same as sender account ID.');
            return false;
        }
        if (amount <= 0) {
            alert('Please enter a valid amount greater than 0.');
            return false;
        }
        return confirm('Are you sure you want to transfer $' + amount + ' from Account ID <%= accountId %> to Account ID ' + recipient + ' ?');
    }
</script>
</body>
</html>