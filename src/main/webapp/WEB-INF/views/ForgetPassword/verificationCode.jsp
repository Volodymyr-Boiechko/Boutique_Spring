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

    <form id="validate">

        <label class="text">
            Введіть отриманий код підтвердження облікового запису
            <input id="code" type="text">
        </label>

        <button class="button button_forgetPassword">Продовжити</button>

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

        let verificationCode = "${sessionScope.verificationCode}";
        let enteredCode = document.getElementById("code").value;

        if (verificationCode === enteredCode) {
            window.location.href = "${pageContext.request.contextPath}/forgetPassword/updatePassword";
        } else {
            alert("Введений код не співпадає");
        }

    });

</script>
</body>
</html>
