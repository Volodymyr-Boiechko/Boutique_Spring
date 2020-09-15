<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Change password</title>
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

            <div class="profile__block info" style="min-height: 500px;">

                <div class="profile__block__title">Змінити пароль</div>
                <div class="profile__block__descr">
                    Ви в будь-який момент можете змінити ваш пароль, щоб забезпечити безпеку вашого профілю
                </div>

                <form id="form" method="post">

                    <label class="info__form__label" style="margin-top: 40px;">
                        <div class="info__form__label_text">Поточний пароль:</div>
                        <input id="currentPassword" type="password">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Новий пароль:</div>
                        <input id="newPassword" type="password">
                    </label>

                    <button id="button" disabled class="info__form__button" type="submit">Зберегти пароль</button>

                </form>

            </div>

        </div>

    </div>

</div>
<div id="userProfileModal"></div>

<jsp:include page="../components/footer.jsp"/>
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

            url: "/userProfile/changePassword",
            async: false,
            type: "POST",
            data: {

                currentPassword: document.getElementById('currentPassword').value,
                newPassword: document.getElementById('newPassword').value,

            }

        }).done(function (response) {

            console.log(response.status);

            document.getElementById('userProfileModal').innerHTML =
                "<div class=\"overlay\" id=\"overlayUpdateUser\">\n" +
                "    <div class=\"modalUser\" id=\"updateUser\">\n" +
                "        <div class=\"modalUser__close\">&times;</div>\n" +
                "        <div class=\"modalUser__subtitle\">Оновлення паролю</div>\n" +
                "        <p class=\"modalUser__descr\">Ваш пароль успішно оновлено</p>\n" +
                "    </div>\n" +
                "</div>";

            $('#overlayUpdateUser, #updateUser').fadeIn('slow');

            $(document).ready(function () {

                $('.modalUser__close').on('click', function () {
                    window.location.reload();
                });
            });

        }).fail(function (response) {

            if (response.status === 401) {
                alert("Неправильно введений теперішній пароль!");
            } else if (response.status === 500) {
                alert("Виникла помилка на сервері");
            }

        });

    });

    setInterval(function () {

        let button = document.querySelector("#button");

        if (checkEmpty() === true) {

            $("button").attr("disabled", "disabled");
            button.classList.remove("active_button");

        } else {
            $("button").removeAttr("disabled");
            button.classList.add("active_button");
        }

    }, 1);

    function checkEmpty() {

        let currentPassword = document.getElementById('currentPassword').value;
        let newPassword = document.getElementById('newPassword').value;

        /*Додати валідацію*/
        if (currentPassword === newPassword) {
            return true;
        }

        return currentPassword === "" || newPassword === "";

    }


</script>
</body>
</html>
