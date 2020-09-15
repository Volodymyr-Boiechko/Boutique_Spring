<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Profile</title>
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

            <div class="profile__block info">

                <div class="profile__block__title">Моя інформація</div>
                <div class="profile__block__descr">Ви можете переглядати і змінювати свої особисті дані</div>

                <form id="form">

                    <label class="info__form__label" style="margin-top: 20px;">
                        <div class="info__form__label_text">Ім'я:</div>
                        <input id="firstName" type="text" value="${sessionScope.user.firstName}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Прізвище:</div>
                        <input id="surname" type="text" value="${sessionScope.user.surname}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Дата народження:</div>
                        <input id="date" type="date" value="${sessionScope.user.birthDate}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Електронна пошта:</div>
                        <input id="email" type="text" value="${sessionScope.user.email}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Номер телефону:</div>
                        <input id="phoneNumber" type="text" value="${sessionScope.user.phoneNumber}">
                    </label>

                    <button id="button" disabled class="info__form__button" type="submit">Зберегти зміни</button>

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

            url: "/userProfile/userInfo",
            async: false,
            type: "POST",
            data: {

                firstName: document.getElementById("firstName").value,
                surname: document.getElementById('surname').value,
                birthDate: document.getElementById('date').value,
                email: document.getElementById('email').value,
                phoneNumber: document.getElementById('phoneNumber').value

            }

        }).done(function (response) {

            console.log(response.status)

            document.getElementById('userProfileModal').innerHTML =
                "<div class=\"overlay\" id=\"overlayUpdateUser\">\n" +
                "    <div class=\"modalUser\" id=\"updateUser\">\n" +
                "        <div class=\"modalUser__close\">&times;</div>\n" +
                "        <div class=\"modalUser__subtitle\">Оновлення інформації</div>\n" +
                "        <p class=\"modalUser__descr\">Ваш профіль успішно оновлено</p>\n" +
                "    </div>\n" +
                "</div>";

            $('#overlayUpdateUser, #updateUser').fadeIn('slow');

            $(document).ready(function () {

                $('.modalUser__close').on('click', function () {
                    window.location.reload();
                });
            });

        }).fail(function (response) {

            console.log(response.status)

            if (response.status === 500) {
                alert("Виникла помилка на сервері");
            }


        });

    });

    setInterval(function () {

        let button = document.querySelector("#button");

        if (checkChanges() === true) {

            $("button").removeAttr("disabled");
            button.classList.add("active_button");

        } else {
            $("button").attr("disabled", "disabled");
            button.classList.remove("active_button");

        }

    }, 1);

    function checkChanges() {

        let firstName = document.getElementById("firstName").value;
        let surname = document.getElementById('surname').value;
        let birthDate = document.getElementById('date').value;
        let email = document.getElementById('email').value;
        let phoneNumber = document.getElementById('phoneNumber').value;

        /*Додати валідацію якщо пустий емейл*/
        if (email === "") {

            return false;
        }

        let firstNameAttribute = "${sessionScope.user.firstName}";
        let surnameAttribute = "${sessionScope.user.surname}";
        let birthDateAttribute = "${sessionScope.user.birthDate}";
        let emailAttribute = "${sessionScope.user.email}";
        let phoneNumberAttribute = "${sessionScope.user.phoneNumber}";

        return !(firstName === firstNameAttribute && surname === surnameAttribute &&
            birthDate === birthDateAttribute && email === emailAttribute && phoneNumber === phoneNumberAttribute);

    }

</script>
</body>
</html>