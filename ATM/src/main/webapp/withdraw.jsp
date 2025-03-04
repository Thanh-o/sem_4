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
    <title>Withdraw Funds</title>
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
            background: linear-gradient(90deg, #dc3545, #c82333);
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

        /* Cải tiến thông báo với Toast */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
        }
        .toast {
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.5s ease;
        }
        .toast-success {
            background: linear-gradient(90deg, #28a745, #218838);
            color: white;
        }
        .toast-error {
            background: linear-gradient(90deg, #dc3545, #c82333);
            color: white;
        }
        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
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
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link" href="history?accountId=<%= accountId %>">
                        <i class="fas fa-history me-1"></i> Transaction History
                    </a>
                </li>
            </ul>

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

<div class="container">
    <div class="card custom-card">
        <div class="card-body">
            <h2 class="text-center text-danger mb-4">
                <i class="fas fa-money-bill-wave me-2"></i> Withdraw Funds
            </h2>
            <p class="text-muted text-center mb-4">Account ID: <%= accountId %> </p>

            <form action="withdraw" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="senderAccountId" value="<%= accountId %>">
                <div class="mb-4">
                    <label class="form-label"><i class="fas fa-dollar-sign me-1"></i> Amount to Withdraw</label>
                    <input type="number" name="amount" class="form-control" step="0.01" min="1"
                           required placeholder="Enter amount (e.g., 100.50)">
                </div>
                <button type="submit" class="btn btn-danger custom-btn">
                    <i class="fas fa-wallet me-2"></i> Withdraw Now
                </button>
            </form>
        </div>
    </div>
</div>

<!-- Toast Container cho thông báo -->
<div class="toast-container">
    <c:if test="${not empty error}">
        <div class="toast toast-error" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">
            <div class="toast-header">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong class="me-auto">Error</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                    ${error}
            </div>
        </div>
        <% session.removeAttribute("error"); %>
    </c:if>
    <c:if test="${not empty message}">
        <div class="toast toast-success" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="5000">
            <div class="toast-header">
                <i class="fas fa-check-circle me-2"></i>
                <strong class="me-auto">Success</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body">
                    ${message}
            </div>
        </div>
        <% session.removeAttribute("message"); %>
    </c:if>
</div>
<!-- Modal xác nhận logout -->
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
<!-- Modal xác nhận rút tiền -->
<div class="modal fade" id="confirmWithdrawModal" tabindex="-1" aria-labelledby="confirmWithdrawModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 15px; background: #fff; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);">
            <div class="modal-header" style="background: linear-gradient(90deg, #dc3545, #c82333); color: white; border-radius: 15px 15px 0 0;">
                <h5 class="modal-title" id="confirmWithdrawModalLabel">
                    <i class="fas fa-exclamation-circle me-2"></i> Confirm Withdrawal
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to withdraw <strong><span id="withdrawAmount"></span></strong> from Account ID <strong><%= accountId %></strong>?</p>
                <div id="errorMessage" class="text-danger mt-2" style="display: none;">
                    <i class="fas fa-exclamation-triangle me-1"></i> Please enter a valid amount greater than 0.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Cancel
                </button>
                <button type="button" class="btn btn-danger" id="confirmWithdrawBtn">
                    <i class="fas fa-check me-1"></i> Confirm
                </button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Khởi tạo Toast
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



    function validateForm() {
        const amountInput = document.querySelector('input[name="amount"]');
        const amount = parseFloat(amountInput.value);
        const confirmModal = new bootstrap.Modal(document.getElementById('confirmWithdrawModal'));
        const withdrawAmountSpan = document.getElementById('withdrawAmount');
        const errorMessageDiv = document.getElementById('errorMessage');
        const confirmBtn = document.getElementById('confirmWithdrawBtn');

        // Reset trạng thái lỗi
        errorMessageDiv.style.display = 'none';
        confirmBtn.disabled = false;

        // Hiển thị số tiền trong modal
        withdrawAmountSpan.textContent = '$' + amount;

        // Kiểm tra số tiền
        if (isNaN(amount) || amount <= 0) {
            errorMessageDiv.style.display = 'block';
            confirmBtn.disabled = true;
            confirmModal.show();
            return false;
        }

        // Hiển thị modal xác nhận
        confirmModal.show();

        // Xử lý sự kiện khi nhấn Confirm
        confirmBtn.onclick = function() {
            confirmModal.hide();
            document.querySelector('form[action="withdraw"]').submit(); // Gửi form khi xác nhận
        };

        return false; // Ngăn form gửi ngay lập tức
    }
</script>
</body>
</html>