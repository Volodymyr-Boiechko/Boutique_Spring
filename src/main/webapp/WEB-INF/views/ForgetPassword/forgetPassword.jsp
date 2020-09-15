<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Recover password</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/forgetPassword.css">
</head>
<body>
<div class="container" style="margin-top: 80px;">

    <h1 class="title">Відновлення паролю</h1>

    <form id="form" class="form">

        <label id="emailLabel">
            Введіть адресу вашої електронної пошти
            <input id="email" type="text">
        </label>

        <button class="button button_forgetPassword">Пошук</button>

    </form>

</div>
<div id="modalForm"></div>

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

            url: "/forgetPassword",
            async: true,
            type: "POST",
            data: {
                email: document.getElementById("email").value
            }

        }).done(function (response) {

            console.log(response.status);

            let email = document.getElementById("email").value

            document.getElementById('modalForm').innerHTML =
                "<div class=\"overlay\">\n" +
                "    <div class=\"modalw modalw_mini\" id=\"info\">\n" +
                "        <div class=\"modalw__close\">&times;</div>\n" +
                "        <div class=\"modalw__subtitle\">Перевірте пошту</div>\n" +
                "        <div class=\"modalw__descr\">\n" +
                "            Код підтвердження надіслано на\n" +
                "            <div id=\"email_text\"></div>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</div>";

            $('.overlay, #info').fadeIn('slow');
            document.getElementById("email_text").innerText = email;

            $(document).ready(function () {

                $('.modalw__close').on('click', function () {
                    $('.overlay, #thanks').fadeOut('slow');
                    window.location.href = "${pageContext.request.contextPath}/forgetPassword/verificationCode";
                });
            });

        }).fail(function (response) {

            if (response.status === 403) {
                alert("Користувача з такою електронною поштою не знайдено");
            }
        });

    });

</script>
</body>
</html>
