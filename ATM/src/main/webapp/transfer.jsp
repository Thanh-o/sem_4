<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        .custom-card {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .custom-btn {
            width: 100%;
            font-size: 1.1rem;
        }
    </style>
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

<div class="container mt-5">
    <div class="card custom-card bg-white">
        <div class="card-body">
            <h2 class="text-center text-primary">
                <i class="fas fa-exchange-alt"></i> Transfer Funds
            </h2>
            <p class="text-muted text-center">Secure and fast money transfer</p>

            <form action="transfer" method="post">
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Recipient ID</label>
                    <input type="number" name="recipient" class="form-control" required placeholder="Enter recipient ID">
                </div>

                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-dollar-sign"></i> Amount to Transfer</label>
                    <input type="number" name="amount" class="form-control" required placeholder="Enter amount">
                </div>

                <button type="submit" class="btn btn-primary custom-btn">
                    <i class="fas fa-paper-plane"></i> Transfer
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
