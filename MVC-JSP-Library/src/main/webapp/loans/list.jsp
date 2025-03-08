<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Borrow Book</title>
</head>
<body>
<h1>Borrow New Book</h1>
<form action="${pageContext.request.contextPath}/loans/borrow" method="post">
    <div>
        <label>Book:</label>
        <select name="bookId" required>
            <c:forEach items="${books}" var="book">
                <option value="${book.id}">${book.title}</option>
            </c:forEach>
        </select>
    </div>
    <div>
        <label>Member:</label>
        <select name="memberId" required>
            <c:forEach items="${members}" var="member">
                <option value="${member.id}">${member.firstName} ${member.lastName}</option>
            </c:forEach>
        </select>
    </div>
    <div>
        <label>Due Date:</label>
        <input type="date" name="dueDate" required>
    </div>
    <button type="submit">Borrow</button>
    <a href="${pageContext.request.contextPath}/loans">Cancel</a>
</form>
</body>
</html>