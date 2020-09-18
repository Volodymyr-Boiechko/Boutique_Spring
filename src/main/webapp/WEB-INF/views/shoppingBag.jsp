<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Shopping Bag</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shoppingBag.css">
</head>
<body>
<jsp:include page="/header"/>
<c:choose>

    <c:when test="${not empty sessionScope.user}">

        <c:if test="${sessionScope.shoppingBag.size() == 0}">

            <div class="headerShoppingBag">

                <div class="container">

                    <img src="${pageContext.request.contextPath}/resources/img/header/basketBlack.png" alt="basket">
                    <div class="headerShoppingBag__title">
                        Ваша корзина пуста
                    </div>
                    <div class="headerShoppingBag__descr">
                        Додавайте в корзину товари, які хочете придбати.
                    </div>
                    <div class="headerShoppingBag__links">

                        <a class="headerShoppingBag__links_link"
                           href="${pageContext.request.contextPath}/favoriteProducts">
                            Переглянути улюблені
                        </a>

                    </div>
                    <a class="headerShoppingBag__link" href="${pageContext.request.contextPath}/">Розпочати шопінг</a>

                </div>

            </div>

        </c:if>

        <c:if test="${sessionScope.shoppingBag.size() != 0}">

            <div class="shoppingBag">

                <div class="container">

                    <div class="row">

                        <div class="col-md-7" id="text">

                            <div class="shoppingBag__bag">

                                <div class="shoppingBag__bag_title">Моя корзина</div>

                                <c:forEach items="${sessionScope.shoppingBag}" var="product">

                                    <div class="shoppingBag__bag__block" id="${product.idProduct}">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem/${product.idProduct}"
                                           class="shoppingBag__bag__block__img">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.typeName}">

                                        </a>

                                        <div class="shoppingBag__bag__block__text">

                                            <div class="shoppingBag__bag__block__text_price">${product.price} грн.</div>
                                            <div class="shoppingBag__bag__block__text_descr">${product.description}</div>

                                            <div class="shoppingBag__bag__block__text__char">

                                                <c:if test="${not empty product.model}">

                                                    <div class="shoppingBag__bag__block__text__char_element">${product.model}</div>

                                                </c:if>

                                                <c:if test="${not empty product.color}">

                                                    <div class="shoppingBag__bag__block__text__char_element">${product.color}</div>

                                                </c:if>

                                                <c:if test="${not empty product.size}">

                                                    <div class="shoppingBag__bag__block__text__char_element">${product.size}</div>

                                                </c:if>

                                                <label class="shoppingBag__bag__block__text__char_count">
                                                    К-сть:
                                                    <select class="select">

                                                        <c:forEach items="${maxQuantity}" var="element">
                                                            <option value="${element}">${element}</option>
                                                        </c:forEach>

                                                    </select>
                                                </label>

                                            </div>

                                            <button onclick="if (addToFavorite(${product.idProduct}) === true) location.reload();"
                                                    class="shoppingBag__bag__block__text__button">

                                                <div class="shoppingBag__bag__block__text__button__img">

                                                    <img id="favorite"
                                                         src="${pageContext.request.contextPath}/resources/img/other/favorite.png"
                                                         alt="favorite">

                                                </div>

                                                <div class="shoppingBag__bag__block__text__button_text">Добавити в
                                                    улюблені
                                                </div>

                                            </button>

                                        </div>

                                        <button onclick="deleteFromShoppingBag(${product.idProduct})"
                                                class="shoppingBag__bag__block__delete">&times;
                                        </button>

                                    </div>

                                </c:forEach>

                                <div class="shoppingBag__bag_totalPrice">
                                    Всього <span class="totalPrice"></span>
                                </div>

                            </div>

                        </div>

                        <div class="col-md-5">

                            <div class="shoppingBag__bag">

                                <div class="shoppingBag__bag__img">
                                    <img src="${pageContext.request.contextPath}/resources/img/profile/address.png" alt="address">
                                </div>

                                <div class="shoppingBag__bag_title">Виберіть адресу</div>

                                <div class="shoppingBag__bag__block">

                                    <c:choose>

                                        <c:when test="${addressesOfUser.size() == 0}">

                                            <div class="shoppingBag__bag__block_title">Для того щоб зробити замовлення
                                                потрібно додати хоча б одну адресу. Це можна зробити у Вашому профілі в
                                                розділі <a class="shoppingBag__bag__block_addressLink" href="${pageContext.request.contextPath}/userProfile/userAddresses">Мої адреси</a>.
                                            </div>

                                        </c:when>
                                        <c:otherwise>

                                            <select id="selectAddresses" class="shoppingBag__bag__block__address">

                                                <c:forEach items="${addressesOfUser}" var="address">

                                                    <option name="${address.idAddress}">

                                                        <div>${address.country}, ${address.city}, ${address.street}</div>

                                                    </option>

                                                </c:forEach>

                                            </select>

                                        </c:otherwise>

                                    </c:choose>


                                </div>

                            </div>

                            <div class="shoppingBag__bag">

                                <div class="shoppingBag__bag_title">Разом</div>

                                <div class="shoppingBag__bag__block shoppingBag__bag__block_price">

                                    <div class="shoppingBag__bag__block__textTotal">

                                        <div class="shoppingBag__bag__block__textTotal_el">
                                            Всього<span class="totalPrice"></span>
                                        </div>
                                        <div class="shoppingBag__bag__block__textTotal_el">
                                            Доставка<span>Безкоштовно</span>
                                        </div>

                                    </div>

                                    <div class="shoppingBag__bag__block_divider"></div>

                                    <button id="makeOrderButton" onclick="makeOrder()"
                                            class="button button_shoppingBag">Зробити
                                        замовлення
                                    </button>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </c:if>

    </c:when>
    <c:otherwise>

        <div class="headerShoppingBag">

            <div class="container">

                <img src="${pageContext.request.contextPath}/resources/img/header/basketBlack.png" alt="basket">
                <div class="headerShoppingBag__title">
                    Ваша корзина пуста
                </div>
                <div class="headerShoppingBag__descr">
                    Увійдіть, щоб переглянути Вашу корзину і здійснювати покупки!
                </div>
                <div class="headerShoppingBag__links">

                    <a class="headerShoppingBag__links_link" href="${pageContext.request.contextPath}/login">Увійти</a>
                    <a class="headerShoppingBag__links_link" href="${pageContext.request.contextPath}/registration">Зареєструватись</a>

                </div>

            </div>

        </div>

    </c:otherwise>

</c:choose>

<jsp:include page="components/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/addToFavorite.js"></script>
<script>

    let selectElement = [];

    let addressesSize = ${addressesOfUser.size() == 0};

    if (addressesSize === true) {

        let button = document.getElementById('makeOrderButton');

        if (button !== null) {

            setInterval(function () {

                button.setAttribute("disabled", "disabled");

            }, 1);

        }
    }

    setInterval(function () {

        let prices = document.querySelectorAll('.totalPrice');

        for (let i = 0; i < prices.length; i++) prices[i].innerText = formPrice() + " грн.";

    }, 500);

    function formPrice() {

        let array = ${pricesOfProducts};
        let price = 0;

        let elements = document.querySelectorAll('.select');
        let copyArray = [];

        for (let i = 0; i < elements.length; i++) {

            copyArray.push(elements[i].value);
        }

        selectElement = copyArray;

        for (let i = 0; i < array.length; i++) price += array[i] * selectElement[i];

        return price.toString();

    }

    function deleteFromShoppingBag(idProduct) {

        let success = false;

        $.ajax({

            url: '/shoppingBag/' + idProduct,
            async: false,
            type: 'DELETE'

        }).done(function (response) {

            success = true;
            console.log(response.status);

            alert('Продукт видалено з корзини');
            location.reload();

        }).fail(function (response) {

            success = false;
            console.log(response.status);

            if (response.status === 500) {
                alert("Виникла помилка на сервері");
            }

        });

        return success;

    }

</script>
</body>
</html>