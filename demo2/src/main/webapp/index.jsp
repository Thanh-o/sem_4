<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🏠 Home</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            animation: fadeIn 0.5s ease-in;
        }

        h1 {
            color: #1a73e8;
            font-weight: 600;
            margin-bottom: 15px;
            font-size: 2rem;
        }

        p {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .btn-primary {
            background: linear-gradient(45deg, #1a73e8, #4285f4);
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(26, 115, 232, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26, 115, 232, 0.6);
            background: linear-gradient(45deg, #4285f4, #1a73e8);
        }

        .btn-primary i {
            margin-right: 10px;
            transition: transform 0.3s ease;
        }

        .btn-primary:hover i {
            transform: translateX(5px);
        }

        /* Animation keyframes */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 576px) {
            .container {
                margin: 20px;
                padding: 25px;
            }
            h1 {
                font-size: 1.5rem;
            }
            p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1><i class="fas fa-rocket me-2"></i> Welcome to JWT MVC</h1>
    <p>Secure login system powered by JSON Web Token</p>
    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
        <i class="fas fa-sign-in-alt"></i> Go to Login Page
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>