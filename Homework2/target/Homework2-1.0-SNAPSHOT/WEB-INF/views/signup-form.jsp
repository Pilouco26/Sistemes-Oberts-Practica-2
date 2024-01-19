<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sign Up</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
        <script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

        <!-- FontAwesome -->
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
              rel="stylesheet"
              integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
              crossorigin="anonymous"/>
        <script>
            $(document).ready(function () {
                // Handle form submission
                $("form").submit(function (e) {
                    e.preventDefault(); // Prevent the form from submitting in the traditional way

                    // Clear existing error messages
                    $(".panel-body .alert").remove();

                    // Get form data
                    var formData = {
                        name: $("input[name='firstName']").val(),
                        email: $("input[name='email']").val(),
                        password: $("input[name='password']").val()
                    };

                    // Store email and password in sessionStorage
                    sessionStorage.setItem('savedEmail', formData.email);
                    sessionStorage.setItem('savedPassword', formData.password);

                    // Make AJAX request to check if the user exists
                    $.ajax({
                        type: "POST",
                        url: "http://localhost:8080/Homework1/rest/api/v1/customer/check",
                        contentType: "application/json; charset=utf-8",
                        headers: {
                            "mailToken": formData.email,
                            "passwordToken": formData.password
                        },
                        success: function (data, status, xhr) {
                            handleResponse(xhr);
                        },
                        error: function (xhr, status, error) {
                            handleResponse(xhr);
                        }
                    });
                });

                // Function to handle both success and error responses
                function handleResponse(xhr) {
                    console.log(xhr.status);
                    if (xhr.status === 202) { // ACCEPTED
                        // Redirect to the success route
                        console.log("exito");
                        window.location.href = "FrontPage";
                    } else if (xhr.status === 401) {
                        // Show an error message for wrong password
                        console.log("401");
                        showError("Incorrect credentials. Please try again.");
                    } else {
                        // Handle other response statuses or continue with form submission
                        e.preventDefault();
                    }
                }

                // Function to show an error message
                function showError(message) {
                    // Add an error message to the form
                    $(".panel-body").append("<div class='alert alert-danger' role='alert'>" + message + "</div>");
                }

                // Check for saved email and password on page load
                var savedEmail = sessionStorage.getItem('savedEmail');
                var savedPassword = sessionStorage.getItem('savedPassword');
                if (savedEmail) {
                    $("input[name='email']").val(savedEmail);
                }
                if (savedPassword) {
                    $("input[name='password']").val(savedPassword);
                }
            });

        </script>

    </head>
    <body>
        <div class="container">
            <div class="col-md-offset-2 col-md-7">
                <h2 class="text-center">Skeleton Structure for Homework 2</h2>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title">Sign Up</div>
                    </div>
                    <div class="panel-body">
                        <form action="${mvc.uri('sign-up')}" class="form-horizontal" method="POST">
                            <input type="hidden" name="${mvc.csrf.name}" value="${mvc.csrf.token}"/>
                            <div class="form-group">
                                <label for="firstname" class="col-md-3 control-label">First Name</label>
                                <div class="col-md-9">
                                    <input type="text" name="firstName" value="${user.firstName}" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="email" class="col-md-3 control-label">Email</label>
                                <div class="col-md-9">
                                    <input type="text" name="email" value="${user.email}" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-md-3 control-label">Password</label>
                                <div class="col-md-9">
                                    <input type="password" name="password" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <!-- Button -->
                                <div class="col-md-offset-3 col-md-9">
                                    <input type="submit" value="Submit" />
                                </div>
                            </div>
                        </form>
                        <c:if test="${not empty message}">
                            <div class="alert alert-danger" role="alert">
                                ${message}        
                            </div>
                        </c:if>
                        <c:if test="${attempts.hasExceededMaxAttempts()}">
                            <div id="too-many-signup-attempts" class="modal top fade" role="alert" tabindex="-1" data-mdb-backdrop="static" data-mdb-keyboard="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h2 class="modal-title" id="too-many-signup-attempts">Please try again later.</h2>
                                        </div>
                                        <div class="modal-body">
                                            <div class="alert alert-danger" role="alert">
                                                <img class="mb-4" src="<c:url value="/resources/img/Invalid.png" />" alt="" width="134" height="92" />
                                                The maximum number of sign up attempts has been exceeded!
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $("#too-many-signup-attempts").modal('show');
                            </script>
                        </c:if>
                        <jsp:include page="/WEB-INF/views/layout/alert.jsp" />
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
    </body>
</html>
