<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
</head>
<body>
<h1>Books</h1>
<a href="${pageContext.request.contextPath}/books/add">Add New Book</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>ISBN</th>
        <th>Available</th>
        <th>Actions</th>
    </tr>
    <c:forEach items="${books}" var="book">
        <tr>
            <td>${book.id}</td>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.isbn}</td>
            <td>${book.available}</td>
            <td>
                <a href="${pageContext.request.contextPath}/books/edit?id=${book.id}">Edit</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>