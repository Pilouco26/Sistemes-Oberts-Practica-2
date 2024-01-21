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
        <script>
            $(document).ready(function () {
                // Obtén los IDs de los juegos desde la sessionStorage
                var cartIds = JSON.parse(sessionStorage.getItem("cartIds")) || [];

                // Llama a una función para cargar los detalles de cada juego en el carrito
                loadGamesDetails(cartIds);

                // Maneja el clic en el botón "Go Back"
                $('#goBackBtn').on('click', function () {
                    // Redirecciona a la página FrontPage
                    window.location.href = 'FrontPage';
                });

                // Maneja el clic en el botón "Rent Me"
                $('#rentMeBtn').on('click', function () {
                    var cartIds = sessionStorage.getItem("cartIds");

                    // Check if there are items in the cartIds list
                    if (cartIds && cartIds.length > 0) {
                        // Construct the URL for the POST request
                        var apiUrl = 'http://localhost:8080/Homework1/rest/api/v1/rental/post';

                        // Construct the request body
                        var requestBody = {
                            ids: JSON.parse(cartIds) // Assuming cartIds is a valid JSON array
                        };

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
                                if (xhr.status === 201) {
                                    // Handle success for status code 201 (Created)
                                    alert('Rent Me successful!');
                                } else if (xhr.status === 401) {
                                    // Handle unauthorized access (status code 401)
                                    alert('Unauthorized access. Please log in.');
                                } else {
                                    // Handle other status codes as needed
                                    alert('Rent Me failed. Please try again.');
                                }
                            },
                            error: function (response, xhr) {
                                if (response.status === 201) {
                                    // Handle success for status code 201 (Created)
                                    var rental = JSON.parse(response.responseText);
                                    alert('Rent Me successful! Price: ' + rental.price + ' Games: ' + rental.games);
                                    sessionStorage.removeItem('cartIds');
                                } else {
                                    // Check the HTTP status code for specific error handling
                                    if (response.status === 401) {
                                        // Handle unauthorized access (status code 401)
                                        alert('Unauthorized access. Please log in.');
                                    } else {
                                        // Handle other error cases as needed
                                        alert('Failed to make Rent Me POST request. Please try again. ' + response.responseText);
                                    }
                                }
                            }
                        });
                    } else {
                        // Optionally, you can inform the user that the cart is empty
                        alert('Cart is empty. Add items before renting.');

                    }
                    window.location.href = 'FrontPage';
                });
            });

            function loadGamesDetails(cartIds) {
                var preu = 0;
                // Loop a través de los IDs de los juegos en el carrito
                cartIds.forEach(function (gameId) {
                    // Realiza una solicitud AJAX para obtener los detalles del juego
                    $.ajax({
                        url: 'http://localhost:8080/Homework1/rest/api/v1/game/get?id=' + gameId,
                        type: 'GET',
                        dataType: 'json',
                        success: function (response) {
                            if (response && response.name) {
                                preu = preu + response.price;
                                console.log('Valor de preu:', preu);
                                $('#totalPrice').text(preu);
                                // Crea el contenido HTML con los detalles del juego
                                var gameDetailsHtml = '<div class="game-details-container">';
                                gameDetailsHtml += '<div class="details-left">';
                                gameDetailsHtml += '<img class="game-image" src="' + response.pathImage + '" alt="Game Image">';
                                gameDetailsHtml += '<p>Descripción: ' + response.description + '</p>';
                                gameDetailsHtml += '</div>';

                                gameDetailsHtml += '<div class="details-right">';
                                gameDetailsHtml += '<h2>' + response.name + '</h2>';
                                gameDetailsHtml += '<p>Preu: $' + response.price + '</p>';
                                gameDetailsHtml += '<p>Tipus: ' + response.type + '</p>';
                                gameDetailsHtml += '<p>Consola: ' + response.console + '</p>';

                                if (response.addresses && response.addresses.length > 0) {
                                    gameDetailsHtml += '<p>Adreces disponibles:</p>';
                                    gameDetailsHtml += '<ul>';
                                    response.addresses.forEach(function (address) {
                                        gameDetailsHtml += '<li>' + address + '</li>';
                                    });
                                    gameDetailsHtml += '</ul>';
                                }
                                gameDetailsHtml += '</div>';

                                $('#gameDetails').append(gameDetailsHtml);
                            } else {
                                console.error('Error al cargar los detalles del juego: Respuesta incorrecta del servidor');
                            }
                        },
                        error: function () {
                            console.error('Error al cargar los detalles del juego con ID ' + gameId);
                        }
                    });
                });
            }
        </script>
    </head>

    <body>
        <div class="game-details-container">
            <!-- Display the game details here -->
            <div id="gameDetails"></div>
            <p class="price-tag">Preu total: $<span id="totalPrice">0</span></p>
            <div class="button-container">
                <button id="goBackBtn" class="btn btn-primary">Go Back</button>
                <button id="rentMeBtn" class="btn btn-success">Rent Me</button>
            </div>
        </div>
    </body>

</html>
