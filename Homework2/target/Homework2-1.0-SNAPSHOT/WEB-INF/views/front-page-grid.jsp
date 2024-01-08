<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Video Game Grid</title>
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
        <script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <style>
            /* Add custom CSS styles for grid layout */
            .game-grid {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .game-item {
                flex: 0 0 calc(33.33% - 10px);
                margin-bottom: 20px;
                box-sizing: border-box;
            }

            /* Adjust the styles as needed */
            .game-item img {
                width: 100%;
                height: auto;
            }
        </style>
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
                                var gameItem = '<div class="game-item">';

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
                    console.log(param1Value);

                    // Fetch data based on filters
                    fetchData(param1Value, param2Value);
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <div>
                <label for="type">Type</label>
                <input type="text" id="type" placeholder="Enter value for type">
            </div>

            <div>
                <label for="console">Console</label>
                <input type="text" id="console" placeholder="Enter value for console">
            </div>

            <button id="fetchDataBtn">Filter</button>

            <div class="game-grid">
                <!-- Game items will be dynamically added here -->
            </div>
        </div>
    </body>
</html>
