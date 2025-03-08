<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Return Book</title>
</head>
<body>
<h1>Return Book</h1>
<form action="${pageContext.request.contextPath}/loans/return" method="post">
    <input type="hidden" name="id" value="${loan.id}">
    <p>Book: ${loan.book.title}</p>
    <p>Member: ${loan.member.firstName} ${loan.member.lastName}</p>
    <p>Borrow Date: ${loan.borrowDate}</p>
    <p>Due Date: ${loan.dueDate}</p>
    <button type="submit">Confirm Return</button>
    <a href="${pageContext.request.contextPath}/loans">Cancel</a>
</form>
</body>
</html>