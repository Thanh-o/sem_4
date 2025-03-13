<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Player List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            text-align: center;
            color: #d2691e;
        }
        .form-container {
            background-color: #f9f9f9;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .form-container label {
            margin-right: 10px;
        }
        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container select {
            padding: 8px;
            margin: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 200px;
        }
        .form-container button {
            padding: 10px 20px;
            background-color: #d2691e;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .form-container button:hover {
            background-color: #b3591a;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #d2691e;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .action-icons a {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
        }
        .action-icons button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            color: #007bff;
        }
        .footer {
            text-align: center;
            background-color: #d2691e;
            color: white;
            padding: 10px;
            margin-top: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<h1>Player Information</h1>

<!-- Form thêm Player -->
<form action="player" method="post" class="form-container">
    <div>
        <label>Player name:</label>
        <input type="text" name="name" required><br>
        <label>Player age:</label>
        <input type="number" name="age" required><br>
        <label>Index name:</label>
        <select name="indexId" required>
            <option value="1">speed</option>
            <option value="1">strength</option>
            <option value="3">accuracy</option>
        </select><br>
        <label>Value:</label>
        <select name="value" required>
            <option value="90">90</option>
            <option value="1">1</option>
        </select>
    </div>
    <button type="submit">Add</button>
</form>

<table>
    <thead>
    <tr>
        <th>Id</th>
        <th>Player name</th>
        <th>Player age</th>
        <th>Index Name</th>
        <th>Value</th>
        <th>Actions</th>
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
            <td class="action-icons">
                <a href="${pageContext.request.contextPath}/edit.jsp?playerId=${player.id}">
                    <img src="edit-icon.png" alt="Edit" style="width: 16px; height: 16px;">
                </a>
                <form action="${pageContext.request.contextPath}/delete" method="post" style="display: inline;">
                    <input type="hidden" name="playerId" value="${player.id}">
                    <button type="submit">
                        <img src="delete-icon.png" alt="Delete" style="width: 16px; height: 16px;">
                    </button>
                </form>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty playerIndices}">
        <tr>
            <td colspan="6">No players found</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div class="footer">
    Số 8, Tôn Thất Thuyết, Cầu Giấy, Hà Nội
</div>
</body>
</html>