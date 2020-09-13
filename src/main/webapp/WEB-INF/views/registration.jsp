<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registration.css">
</head>
<body>

<div class="container" style="margin-top: 80px;">

    <h1 class="title">Реєстрація</h1>

    <form class="form" id="form">

        <label class="form__label">
            <b>Логін</b>
            <input id="username" type="text">
        </label>

        <label class="form__label">
            <b>Пароль</b>
            <input id="password" type="password">
        </label>

        <label class="form__label">
            <b>Підтвердження</b>
            <input id="confirm" type="password">
        </label>

        <label class="form__label">
            <b>Дата<br>народження</b>
            <input id="date" class="long birth" type="date">
        </label>

        <label class="form__label">
            <b>Електронна<br>пошта</b>
            <input id="email" class="long" type="text">
        </label>

        <button class="button button_registration">Зареєструватись</button>

        <div class="form__under">
            Вже зареєстровані?
            <a href="${pageContext.request.contextPath}/login">Увійти</a>
        </div>

    </form>
</div>

<div class="overlay">
    <div class="modalw modalw_registration" id="thanks">
        <div class="modalw__close">&times;</div>
        <div class="modalw__subtitle">Завершення реєстрації</div>
        <p class="modalw__descr">Для завершення реєстрації та активації Вашого</p>
        <p class="modalw__descr">акаунту перевірте електронну пошту та</p>
        <p class="modalw__descr">перейдіть за посилання, яке міститься в листі</p>
    </div>
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

    $(document).ready(function () {

        $('.modalw__close').on('click', function () {
            window.location.href = "${pageContext.request.contextPath}/login";
        });
    });

    $("form").submit(function (e) {

        e.preventDefault();

        let password = document.getElementById('password').value;
        let confirmPassword = document.getElementById('confirm').value;

        if (password !== confirmPassword) {

            alert("Паролі відрізняються!");
            return false;
        }

        $.ajax({

            url: "/registration",
            async: true,
            type: "POST",
            data: {

                username: document.getElementById('username').value,
                password: password,
                date: document.getElementById('date').value,
                email: document.getElementById('email').value

            }
        }).done(function (response) {

            console.log(response.status);
            $('.overlay, #thanks').fadeIn('slow');

        }).fail(function (response) {

            if (response.status === 403) {
                alert("Такий користувач вже існує");
            } else if (response.status === 500) {
                alert("Не вдалось зареєструватись!");
            }

        });

    });


</script>
</body>
</html>
