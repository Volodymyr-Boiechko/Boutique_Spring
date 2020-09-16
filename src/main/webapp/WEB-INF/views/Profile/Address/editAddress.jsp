<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit address</title>
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

                <div class="profile__block__title">Змінити адресу</div>
                <div class="profile__block__descr">
                    Оновіть вашу адресу, і в подальшому всі ярлики для доставки будуть автоматично відображати зазначену
                    нижче адресу
                </div>

                <form id="editAddress" style="margin-top: 40px;">

                    <label class="info__form__label" style="margin-top: 20px;">
                        <div class="info__form__label_text">Країна:</div>
                        <input id="countryEdit" type="text" value="${address.country}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Місто:</div>
                        <input id="cityEdit" type="text" value="${address.city}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Вулиця:</div>
                        <input id="streetEdit" type="text" value="${address.street}">
                    </label>

                    <label class="info__form__label">
                        <div class="info__form__label_text">Поштовий індекс:</div>
                        <input id="postCodeEdit" type="text" value="${address.postCode}">
                    </label>

                    <button id="editButton" disabled class="info__form__button">Зберегти зміни</button>

                </form>

                <%--<c:if test="${canPersonDeleteAddress}">--%>
                <button onclick="deleteAddress(${address.idAddress})"
                        class="info__form__button active_button delete">Видалити адресу
                </button>
                <%--</c:if>--%>

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
<script src="${pageContext.request.contextPath}/resources/js/deleteAddress.js"></script>
<script>

    document.getElementById("editAddress").onsubmit = function (e) {

        e.preventDefault();

        $.ajax({

            url: "/userProfile/userAddresses/editAddress/" + ${address.idAddress},
            async: false,
            type: "POST",
            data: {
                country: document.getElementById("countryEdit").value,
                city: document.getElementById("cityEdit").value,
                street: document.getElementById("streetEdit").value,
                postCode: document.getElementById("postCodeEdit").value
            }

        }).done(function (response) {

            console.log(response.status);

            document.getElementById("userProfileModal").innerHTML =
                "<div class=\"overlay\" id=\"overlayUpdateUser\">\n" +
                "    <div class=\"modalUser\" id=\"updateUser\">\n" +
                "        <div class=\"modalUser__close\">&times;</div>\n" +
                "        <div class=\"modalUser__subtitle\">Оновлення адреси</div>\n" +
                "        <p class=\"modalUser__descr\">Вашу адресу успішно оновлено</p>\n" +
                "    </div>\n" +
                "</div>";

            $('#overlayUpdateUser, #updateUser').fadeIn('slow');

            $(document).ready(function () {

                $('.modalUser__close').on('click', function () {
                    window.location.href = "${pageContext.request.contextPath}/userProfile/userAddresses"
                });
            });

        }).fail(function (response) {

            console.log(response.status);

            if (response.status === 500) {
                alert("Не вдалось редагувати адресу, виникла проблема на сервері");
            }

        });


    };

    setInterval(function () {

        let button = document.querySelector("#editButton");

        if (checkChanges() === true) {

            $("#editButton").removeAttr("disabled");
            button.classList.add("active_button");

        } else {
            $("#editButton").attr("disabled", "disabled");
            button.classList.remove("active_button");

        }

    }, 1);

    function checkChanges() {

        let country = document.getElementById("countryEdit").value;
        let city = document.getElementById('cityEdit').value;
        let street = document.getElementById('streetEdit').value;
        let postCOde = document.getElementById('postCodeEdit').value;

        let countryAttribute = "${address.country}";
        let cityAttribute = "${address.city}";
        let streetAttribute = "${address.street}";
        let postCodeAttribute = "${address.postCode}";

        return !(country === countryAttribute && city === cityAttribute &&
            street === streetAttribute && postCOde === postCodeAttribute);

    }

</script>
</body>
</html>
