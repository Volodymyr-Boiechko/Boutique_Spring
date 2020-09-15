<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login page</title>
    <link rel="shortcut icon" href="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>
<body>

<div class="container" style="margin-top: 80px;">

    <h1 class="title">Вхід</h1>

    <form class="form"  >

        <label>
            <b>Логін</b>
            <input class="form__input" id="username" type="text" placeholder="Введіть логін">
        </label>

        <label>
            <b>Пароль</b>
            <input class="form__input" id="password" type="password" placeholder="Введіть пароль">
        </label>

        <div class="form__under">
            <label id="remember">
                <input id="saveUser" type="checkbox" checked="checked">
                Запам'ятати мене
            </label>

            <a class="form_link form_link_forget" href="${pageContext.request.contextPath}/forgetPassword">Забули
                пароль?</a>

        </div>

        <button class="button button_login">Увійти</button>

        <a class="form_link form_link_reg" href="${pageContext.request.contextPath}/registration">Зареєструватися</a>

    </form>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<script>

    $("form").submit(function (e) {

        e.preventDefault();

        $.ajax({

            url: "/login",
            async: false,
            type: "POST",
            data: {

                username: document.getElementById('username').value,
                password: document.getElementById('password').value,
                saveUserInBrowser: document.getElementById('saveUser').value

            }
        }).done(function (response) {

            console.log(response.status);
            window.location.href = "${pageContext.request.contextPath}/homePage";

        }).fail(function (response) {

            if (response.status === 400) {
                alert("Активуйте акаунт");
            } else if (response.status === 401) {
                alert("Неправильно введений пароль!")
            } else if (response.status === 403) {
                alert("Користувача з таким логіном не знайдено!");
            } else if (response.status === 500) {
                alert("Виникла помилка на сервері");
            }
        });

    });


</script>
</body>
</html>
