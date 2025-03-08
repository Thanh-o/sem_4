<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
</head>
<body>
<h1>Edit Book</h1>
<form action="${pageContext.request.contextPath}/books/edit" method="post">
    <input type="hidden" name="id" value="${book.id}">
    <div>
        <label>Title:</label>
        <input type="text" name="title" value="${book.title}" required>
    </div>
    <div>
        <label>Author:</label>
        <input type="text" name="author" value="${book.author}">
    </div>
    <div>
        <label>ISBN:</label>
        <input type="text" name="isbn" value="${book.isbn}">
    </div>
    <div>
        <label>Available:</label>
        <input type="checkbox" name="available" value="true" ${book.available ? 'checked' : ''}>
    </div>
    <button type="submit">Update</button>
    <a href="${pageContext.request.contextPath}/books">Cancel</a>
</form>
</body>
</html>