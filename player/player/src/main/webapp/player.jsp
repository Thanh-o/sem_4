<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Player Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #d4a017;
            text-align: center;
        }
        .form-container {
            margin-bottom: 20px;
        }
        .form-container input, .form-container select {
            padding: 8px;
            margin: 5px;
            width: 200px;
        }
        .form-container button {
            padding: 8px 20px;
            background-color: #b85c38;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #b85c38;
            color: white;
        }
        .actions a {
            margin-right: 10px;
            text-decoration: none;
        }
        .footer {
            margin-top: 20px;
            padding: 10px;
            background-color: #b85c38;
            color: white;
            text-align: center;
        }
    </style>
</head>
<body>
<h2>PLAYER INFORMATION</h2>

<!-- Form to add new player-index entry -->
<div class="form-container">
    <form action="player" method="post">
        <input type="text" name="playerName" placeholder="Player name" required />
        <input type="number" name="playerAge" placeholder="Player age" required />
        <select name="indexName" required>
            <option value="" disabled selected>INDEX name</option>
            <option value="speed">speed</option>
            <option value="strength">strength</option>
            <option value="accurate">accurate</option>
        </select>
        <select name="value" required>
            <option value="" disabled selected>value</option>
            <option value="90">90</option>
            <option value="1">1</option>
        </select>
        <button type="submit">Add</button>
    </form>
</div>

<!-- Table to display player-index data -->
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Player name</th>
        <th>Player age</th>
        <th>INDEX name</th>
        <th>Value</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="playerIndex" items="${playerIndices}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>${playerIndex.playerName}</td>
            <td>${playerIndex.age}</td>
            <td>${playerIndex.indexName}</td>
            <td>${playerIndex.value}</td>
            <td class="actions">
                <a href="#">✏️</a>
                <a href="#">🗑️</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Footer -->
<div class="footer">
    Số 8, Tôn Thất Thuyết, Cầu giấy, Hà Nội
</div>
</body>
</html>