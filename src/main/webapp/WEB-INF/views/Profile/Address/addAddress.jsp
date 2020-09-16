<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add address</title>
    <link rel="shortcut icon" href="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userProfile.css">
</head>
<body>
<jsp:include page="/header"/>
<div class="profile">

    <div class="container">

        <div class="profile__wrapper">

            <jsp:include page="/userProfile/navProfile"/>

            <div class="profile__block info" style="min-height: 700px;">

                <div class="profile__block__title">Добавити нову адресу</div>
                <div class="profile__block__descr">
                    Будь ласка, введіть адресу, на яку повинна бути здійснена доставка
                </div>

                <form id="form" style="margin-top: 40px;">

                    <label class="info__form__label" style="margin-top: 20px;">
                        <div class="info__form__label_text">Країна:</div>
                        <input id="countryAdd" type="text">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Місто:</div>
                        <input id="cityAdd" type="text">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Вулиця:</div>
                        <input id="streetAdd" type="text">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Поштовий індекс:</div>
                        <input id="postCodeAdd" type="text">
                    </label>

                    <button id="button" class="info__form__button active_button" type="submit">Зберегти адресу</button>

                </form>

            </div>

        </div>

    </div>

</div>
<div id="userProfileModal"></div>
<jsp:include page="../../components/footer.jsp"/>
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

            url: "/userProfile/userAddresses/addAddress",
            async: false,
            type: "POST",
            data: {

                country: document.getElementById("countryAdd").value,
                city: document.getElementById("cityAdd").value,
                street: document.getElementById("streetAdd").value,
                postCode: document.getElementById("postCodeAdd").value

            }

        }).done(function (response) {

            console.log(response.status);

            document.getElementById("userProfileModal").innerHTML =
                "<div class=\"overlay\" id=\"overlayUpdateUser\">\n" +
                "    <div class=\"modalUser\" id=\"updateUser\">\n" +
                "        <div class=\"modalUser__close\">&times;</div>\n" +
                "        <div class=\"modalUser__subtitle\">Добавлення адреси</div>\n" +
                "        <p class=\"modalUser__descr\">Нову адресу успішно добавлено до вашого профілю</p>\n" +
                "    </div>\n" +
                "</div>";

            $('#overlayUpdateUser, #updateUser').fadeIn('slow');

            $(document).ready(function () {

                $('.modalUser__close').on('click', function () {
                    window.location.href = "${pageContext.request.contextPath}/userProfile/userAddresses"
                });
            });

        }).fail(function (response) {

            if (response.status === 500) {
                alert("Не вдалось додати нову адресу, виникла проблема на сервері");
            }

        });


    });

</script>
</body>
</html>
