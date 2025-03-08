<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
</head>
<body>
<h1>Add New Book</h1>
<form action="${pageContext.request.contextPath}/books/add" method="post">
    <div>
        <label>Title:</label>
        <input type="text" name="title" required>
    </div>
    <div>
        <label>Author:</label>
        <input type="text" name="author">
    </div>
    <div>
        <label>ISBN:</label>
        <input type="text" name="isbn">
    </div>
    <div>
        <label>Available:</label>
        <input type="checkbox" name="available" value="true" checked>
    </div>
    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/books">Cancel</a>
</form>
</body>
</html>