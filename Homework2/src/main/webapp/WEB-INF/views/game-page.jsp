<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Game Details</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/styles.css" />" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .game-details-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .game-details-container h2 {
            color: #007bff;
        }

        .game-image {
            max-width: 100%;
            border-radius: 8px;
        }

        .price-tag {
            font-size: 24px;
            color: #28a745;
            margin-top: 10px;
        }

        #addToCartBtn {
            margin-top: 20px;
        }
    </style>
    <script>
        // ... (your existing JavaScript code)
    </script>
</head>

<body>
    <div class="game-details-container">
        <!-- Display the game details here -->
        <div id="gameDetails"></div>
        <button id="addToCartBtn" class="btn btn-primary">Add to Cart</button>
    </div>
</body>

</html>
