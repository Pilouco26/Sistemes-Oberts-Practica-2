
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
                    var cartIds = sessionStorage.getItem("cartIds");

                    // Check if there are items in the cartIds list
                    console.log(cartIds);
                    if (cartIds.length > 0) {
                        // Construct the URL for the POST request
                        var apiUrl = 'http://localhost:8080/Homework1/rest/api/v1/rental/post';
                        // Construct the request body
                        var requestBody = {
                            ids: JSON.parse(cartIds) // Assuming cartIds is a valid JSON array
                        };
                        console.log("request vofyd");
                        console.log(JSON.stringify(requestBody));
                        email = sessionStorage.getItem('savedEmail');
                        password = sessionStorage.getItem('savedPassword');
                        // Perform the POST request
                        $.ajax({
                            url: apiUrl,
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(requestBody),
                            headers: {
                                'mailToken': email,
                                'passwordToken': password
                            },
                            success: function (response, xhr) {
                                console.log('Rent Me POST successful:', response);
                                // Check the HTTP status code
                                if (xhr.status === 201) {
                                    // Handle success for status code 201 (Created)
                                    alert('Rent Me successful!');
                                } else if (xhr.status === 401) {
                                    // Handle unauthorized access (status code 401)
                                    console.error('Unauthorized access:', response);
                                    alert('Unauthorized access. Please log in.');
                                } else {
                                    // Handle other status codes as needed
                                    console.error('Rent Me POST request failed with status code:', xhr.status);
                                    alert('Rent Me failed. Please try again.');
                                }
                            },
                            error: function (response, xhr) {
                                if (response.status === 201) {
                                    // Handle success for status code 201 (Created)
                                    var rental = JSON.parse(response.responseText);
                                    console.log('Rent Me successful!', rental);
                                    alert('Rent Me successful! Identifier: '+400+' Price: ' + rental.price+' Games: '+rental.games);
                                    sessionStorage.removeItem('cartIds');
                                } else {
                                    console.log(response);
                                    // Check the HTTP status code for specific error handling
                                    if (response.status === 401) {
                                        // Handle unauthorized access (status code 401)
                                        console.error('Unauthorized access:', xhr.responseText);
                                        alert('Unauthorized access. Please log in.');
                                    } else {
                                        // Handle other error cases as needed
                                        alert('Failed to make Rent Me POST request. Please try again. '+response.responseText);
                                    }
                                }

                            }
                        });
                    } else {
                        console.log('Cart is empty. Add items before renting.');
                        // Optionally, you can inform the user that the cart is empty
                        alert('Cart is empty. Add items before renting.');
                    }
                });

            });
        </script>
    </head>
    <body>
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-12 text-right mt-2">
                    <!-- Reemplaza 'NOMBRE_USUARIO' con la variable que contiene el nombre del usuario después del inicio de sesión -->
                    <c:if test="${sessionStorage.getItem('loggedUser') ne null}">
                        <p class="text-success">Benvingut!</p>
                    </c:if>
                    <c:if test="${sessionStorage.getItem('loggedUser') eq null}">
                        <!-- Si el usuario no ha iniciado sesión, muestra el botón de inicio de sesión -->
                        <a class="btn btn-primary" href="<c:url value='/Web/SignUp' />">Log in</a>
                    </c:if>
                </div>
            </div>
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
            <div class="row">
                <div class="col-md-12">
                    <!-- Espacio adicional entre el botón "Rent Me" y la sección de juegos -->
                </div>
            </div>
            <div class="game-grid row">
                <!-- Game items will be dynamically added here -->
            </div>
        </div>
    </body>
</html>
