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
                overflow: hidden;
            }

            .game-details-container h2 {
                color: #007bff;
            }

            .game-image {
                max-width: 100%;
                border-radius: 8px;
            }

            .details-left {
                float: left;
                width: 50%;
                padding-right: 20px;
                box-sizing: border-box;
            }

            .details-right {
                float: left;
                width: 50%;
                box-sizing: border-box;
            }

            .price-tag {
                font-size: 24px;
                color: #28a745;
                margin-top: 10px;
            }

            #addToCartBtn {
                clear: both;
                margin-top: 20px;
            }
        </style>
        <script>
            $(document).ready(function () {
                // Obtén el ID del juego de la URL
                var gameId = getParameterByName('id');

                // Llama a una función para cargar los detalles del juego
                loadGameDetails(gameId);

                // Maneja el clic en el botón "Add to Cart"
                $('#addToCartBtn').on('click', function () {
                    addToCart(gameId);
                });
            });

            function loadGameDetails(gameId) {
                // Realiza una solicitud AJAX para obtener los detalles del juego
                $.ajax({
                    url: 'http://localhost:8080/Homework1/rest/api/v1/game/get?id=' + gameId,
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response && response.name) {
                            // Crea el contenido HTML con los detalles del juego
                            var gameDetailsHtml = '<div class="details-left">';
                            gameDetailsHtml += '<img class="game-image" src="' + response.pathImage + '" alt="Game Image">';
                            // Asume que hay una propiedad "description" en la respuesta JSON
                            gameDetailsHtml += '<p>Descripció: ' + response.description + '</p>';
                            gameDetailsHtml += '</div>';

                            gameDetailsHtml += '<div class="details-right">';
                            gameDetailsHtml += '<h2>' + response.name + '</h2>';
                            gameDetailsHtml += '<p class="price-tag">Preu: $' + response.price + '</p>';
                            // Asume que hay propiedades como "type" y "console" en la respuesta JSON
                            gameDetailsHtml += '<p>Tipus: ' + response.type + '</p>';
                            gameDetailsHtml += '<p>Consola: ' + response.console + '</p>';

                            // Asume que hay una propiedad "addresses" en la respuesta JSON, que es un array
                            if (response.addresses && response.addresses.length > 0) {
                                gameDetailsHtml += '<p>Direccions:</p>';
                                gameDetailsHtml += '<ul>';
                                response.addresses.forEach(function (address) {
                                    gameDetailsHtml += '<li>' + address + '</li>';
                                });
                                gameDetailsHtml += '</ul>';
                            }
                            gameDetailsHtml += '</div>';

                            // Agrega los detalles del juego al contenedor
                            $('#gameDetails').html(gameDetailsHtml);
                        } else {
                            console.error('Error al cargar los detalles del juego: Respuesta incorrecta del servidor');
                        }
                    },
                    error: function () {
                        console.error('Error al cargar los detalles del juego.');
                    }
                });
            }

            function addToCart(gameId) {
                // Obtiene los IDs de la sessionStorage o inicializa un array vacío si no existe
                var cartIds = JSON.parse(sessionStorage.getItem("cartIds")) || [];

                // Verifica si el ID ya está en el array antes de agregarlo
                if (cartIds.indexOf(gameId) === -1) {
                    // Si no existe, agrega el nuevo ID al array
                    cartIds.push(gameId);

                    // Guarda el array actualizado en la sessionStorage
                    sessionStorage.setItem("cartIds", JSON.stringify(cartIds));

                    // Puedes realizar acciones adicionales según tus necesidades
                    console.log('Game with ID ' + gameId + ' added to cart. Cart now contains: ' + JSON.stringify(cartIds));
                } else {
                    console.log('Game with ID ' + gameId + ' is already in the cart.');
                }
                window.location.href = 'FrontPage';
            }


            // Función para obtener parámetros de la URL
            function getParameterByName(name) {
                var url = window.location.href;
                name = name.replace(/[\[\]]/g, '\\$&');
                var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                        results = regex.exec(url);
                if (!results)
                    return null;
                if (!results[2])
                    return '';
                return decodeURIComponent(results[2].replace(/\+/g, ' '));
            }
        </script>

    </head>

    <body>
        <div class="game-details-container">
            <!-- Display the game details here -->
            <div id="gameDetails"></div>
            <button id="addToCartBtn" class="btn btn-primary">Add to Cart</button>
        </div>
    </body>