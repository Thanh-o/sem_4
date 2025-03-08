<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🔐 Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            animation: slideUp 0.5s ease-out;
        }

        h2 {
            color: #1e3c72;
            font-weight: 600;
            margin-bottom: 25px;
            font-size: 1.8rem;
        }

        .form-control {
            border: none;
            border-radius: 10px;
            padding: 12px 15px;
            background: #f1f3f6;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 8px rgba(30, 60, 114, 0.3);
            background: #fff;
            border: 1px solid #1e3c72;
        }

        .btn-primary {
            background: linear-gradient(45deg, #1e3c72, #2a5298);
            border: none;
            padding: 12px;
            border-radius: 10px;
            font-weight: 500;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(30, 60, 114, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(30, 60, 114, 0.5);
            background: linear-gradient(45deg, #2a5298, #1e3c72);
        }

        .btn-primary i {
            margin-right: 10px;
            transition: transform 0.3s ease;
        }

        .btn-primary:hover i {
            transform: translateX(5px);
        }

        .error-message {
            color: #dc3545;
            margin-top: 15px;
            font-size: 0.9rem;
            background: rgba(220, 53, 69, 0.1);
            padding: 8px;
            border-radius: 5px;
            animation: fadeIn 0.3s ease-in;
        }

        /* Animations */
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Responsive */
        @media (max-width: 576px) {
            .login-container {
                margin: 20px;
                padding: 30px;
            }
            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2><i class="fas fa-user-lock me-2"></i> Login</h2>

    <form action="${pageContext.request.contextPath}/auth" method="post">
        <div class="mb-3">
            <input type="text" name="username" class="form-control" placeholder="Username" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>

        <button type="submit" class="btn btn-primary">
            <i class="fas fa-sign-in-alt"></i> Login
        </button>
    </form>

    <!-- Display error message (if any) -->
    <c:if test="${not empty error}">
        <p class="error-message">${error}</p>
    </c:if>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>