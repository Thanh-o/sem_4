<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fptaptech.demo2.model.Book" %>
<%@ page import="com.fptaptech.demo2.Service.BookService" %>
<%
    int bookId = Integer.parseInt(request.getParameter("id"));
    BookService bookService = new BookService();
    Book book = bookService.getBookById(bookId);
    if (book == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>✏️ Edit Book</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.2);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .card-header {
            background: linear-gradient(90deg, #007bff, #00b7ff);
            color: white;
            padding: 15px;
            border-radius: 12px 12px 0 0;
            margin: -30px -30px 20px -30px;
            text-align: center;
        }

        .form-label {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 10px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        .btn-primary {
            background: linear-gradient(90deg, #007bff, #00b7ff);
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            transition: transform 0.2s ease;
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            background: linear-gradient(90deg, #0056b3, #0095d6);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .form-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card-header">
        <h2 class="mb-0"><i class="fas fa-book me-2"></i>Edit Book</h2>
    </div>

    <form action="editBook" method="post">
        <input type="hidden" name="id" value="<%= book.getId() %>">

        <div class="form-group">
            <label for="title" class="form-label">Book Title</label>
            <input type="text"
                   id="title"
                   name="title"
                   class="form-control"
                   value="<%= book.getTitle() %>"
                   required>
        </div>

        <div class="form-group">
            <label for="author" class="form-label">Author</label>
            <input type="text"
                   id="author"
                   name="author"
                   class="form-control"
                   value="<%= book.getAuthor() %>"
                   required>
        </div>

        <div class="form-group">
            <label for="quantity" class="form-label">Quantity</label>
            <input type="number"
                   id="quantity"
                   name="quantity"
                   class="form-control"
                   value="<%= book.getQuantity() %>"
                   min="0"
                   required>
        </div>

        <button type="submit" class="btn btn-primary">
            <i class="fas fa-save me-2"></i>Update Book
        </button>
    </form>

    <a href="admin.jsp" class="back-link">
        <i class="fas fa-arrow-left me-2"></i>Back to List
    </a>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>