<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Member List</title>
</head>
<body>
<h1>Members</h1>
<a href="${pageContext.request.contextPath}/members/add">Add New Member</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    <c:forEach items="${members}" var="member">
        <tr>
            <td>${member.id}</td>
            <td>${member.firstName}</td>
            <td>${member.lastName}</td>
            <td>${member.email}</td>
            <td>
                <a href="${pageContext.request.contextPath}/members/edit?id=${member.id}">Edit</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>