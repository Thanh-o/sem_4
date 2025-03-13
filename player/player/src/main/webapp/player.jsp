<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Player List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .form-container {
            margin: 20px 0;
        }
        .form-container input, .form-container select {
            padding: 5px;
            margin: 5px;
        }
        .form-container button {
            padding: 5px 10px;
            background-color: #d2691e;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #b3591a;
        }
    </style>
</head>
<body>
<h1>Player List</h1>

<!-- Hiển thị thông báo -->
<c:if test="${not empty message}">
    <p style="color: green;">${message}</p>
</c:if>

<!-- Form thêm Player -->
<h2>Add Player</h2>
<form action="player" method="post">
    Name: <input type="text" name="name" required><br>

    Age: <input type="number" name="age" required><br>
    Index ID: <input type="number" name="indexId" required><br>
    Value: <input type="number" step="0.1" name="value" required><br>
    <input type="submit" value="Add Player">
</form>
<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Player name</th>
        <th>Player age</th>
        <th>Index Name</th>
        <th>Value</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${playerIndices}" var="player" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${player.playerName}</td>
            <td>${player.age}</td>
            <td>${player.indexName}</td>
            <td>${player.value}</td>
            <td>
                <a href="${pageContext.request.contextPath}/edit.jsp?playerId=${player.id}">
                    <button class="edit-btn">Edit</button>
                </a>
                <form action="${pageContext.request.contextPath}/delete" method="post" style="display: inline;">
                    <input type="hidden" name="playerId" value="${player.id}">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty playerIndices}">
        <tr>
            <td colspan="5">No players found</td>
        </tr>
    </c:if>
    </tbody>
</table>
</body>
</html>