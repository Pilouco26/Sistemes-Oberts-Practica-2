
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Video Game Grid</title>
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
        <link rel="stylesheet" href="<c:url value="/resources/css/frontpage.css" />"> <!-- Add your custom styles here -->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
        <script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
        <script>
            $(document).ready(function () {
                // Function to fetch data based on filters
                function fetchData(type, consoleValue) {
                    // Construct the URL with query parameters
                    var apiUrl = 'http://localhost:8080/Homework1/rest/api/v1/game/find';
                    apiUrl += '?type=' + type;
                    apiUrl += '&console=' + encodeURIComponent(consoleValue);

                    $.ajax({
                        url: apiUrl,
                        type: 'GET',
                        dataType: 'json',
                        async: false,
                        success: function (data) {
                            $('.game-grid').empty(); // Clear existing items
                            data.forEach(function (game) {
                                var gameItem = '<div class="game-item" onclick="redirectToGamePage(' + game.id + ')">';

                                gameItem += `<img class="mb-4" src="`;
                                gameItem += game.pathImage;
                                gameItem += `" alt="" width="100%" />`;
                                gameItem += '<h4>' + game.name + '</h4>';
                                gameItem += '</div>';

                                $('.game-grid').append(gameItem);
                            });
                        },
                        error: function () {
                            console.error('Failed to fetch game data.');
                        }
                    });
                }

                // Fetch data initially when the page loads
                fetchData('', '');

                // Event handler for the "Filter" button
                $('#fetchDataBtn').on('click', function () {
                    console.log("Button clicked");

                    // Get the values entered by the user
                    var param1Value = $('#type').val();
                    var param2Value = $('#console').val();
                    console.log(param1Value);
                    console.log(param2Value);

                    // Fetch data based on filters
                    fetchData(param1Value, param2Value);
                });
            });

            // Function to redirect to GamePage with the given game id
            function redirectToGamePage(gameId) {
                window.location.href = 'GamePage?id=' + gameId;
            }
        </script>
        <script>
            $(document).ready(function () {
                // ... (existing code)

                var cartIds = sessionStorage.getItem("cartIds");

                // ... (existing code)

                // Event handler for the "Rent Me" button
                // Event handler for the "Rent Me" button
                $('#rentMeBtn').on('click', function () {
                    window.location.href = 'RentConfirm';
                });

            });
        </script>
    </head>
    <body>
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="type">Type</label>
                        <input type="text" class="form-control" id="type" placeholder="Enter value for type">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="console">Console</label>
                        <input type="text" class="form-control" id="console" placeholder="Enter value for console">
                    </div>
                </div>
                <div class="col-md-2">
                    <button id="fetchDataBtn" class="btn btn-primary btn-block">Filter</button>
                </div>
                <div class="col-md-2">
                    <button id="rentMeBtn" class="btn btn-success btn-block">Rent Me</button>
                </div>
            </div>

            <div class="game-grid row">
                <!-- Game items will be dynamically added here -->
            </div>
        </div>
    </body>
</html>
