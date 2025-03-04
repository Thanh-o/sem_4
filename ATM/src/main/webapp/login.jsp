<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            background: #ffffff;
            transition: transform 0.3s ease;
        }

        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #ced4da;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        .btn-login {
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            background: linear-gradient(90deg, #007bff, #0056b3);
            border: none;
            transition: background 0.3s ease;
        }
        .btn-login:hover {
            background: linear-gradient(90deg, #0056b3, #003d82);
        }
        .title {
            font-weight: 700;
            color: #333;
            margin-bottom: 2rem;
        }
        .error-message {
            font-size: 0.9rem;
            transition: opacity 0.3s ease;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card login-card" style="width: 400px;">
        <h2 class="text-center title">Welcome Back</h2>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="username" class="form-label fw-semibold">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
                </div>
            </div>
            <div class="mb-4">
                <label for="password" class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 btn-login">Sign In</button>
        </form>
        <p class="text-danger text-center mt-3 error-message">${error}</p>
        <div class="text-center mt-3">
            <a href="#" class="text-muted text-decoration-none small">Forgot Password?</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Thêm Bootstrap Icons nếu muốn sử dụng icon -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>