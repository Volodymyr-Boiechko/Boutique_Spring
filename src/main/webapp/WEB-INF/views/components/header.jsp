<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Чоловічий одяг</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
<div class="over"></div>

<header class="header">

    <div style="height: 75px;" class="container">

        <div class="row">

            <div class="col-md-3">

                <div class="header__gender">

                    <a href="${pageContext.request.contextPath}/clothes/manClothes"
                       class="header__gender_element header__gender_left">
                        чоловіки
                    </a>
                    <span>|</span>
                    <a href="${pageContext.request.contextPath}/clothes/womanClothes" class="header__gender_element">
                        жінки
                    </a>

                </div>

            </div>

            <div class="col-md-4 offset-md-2">
                <a href="${pageContext.request.contextPath}/">
                    <img class="header__logo" src="${pageContext.request.contextPath}/resources/img/header/logo.png"
                         alt="logo">
                </a>
            </div>

            <div class="col-md-2 offset-md-1">
                <div class="header__icons">
                    <div id="profile" class="header__icons_icon">
                        <img class="header__icons_icon_img"
                             src="${pageContext.request.contextPath}/resources/img/header/profile.png" alt="profile">
                        <div id="dropDown" class="header__profileBlock">

                            <div id="close">&times;</div>

                            <c:choose>

                                <c:when test="${sessionScope.user != null}">

                                    <div class="header__profileBlock__user">
                                        <div class="header__profileBlock__user_text">
                                            Привіт ${sessionScope.user.username}</div>
                                        <a href="${pageContext.request.contextPath}/logout">Вийти</a>
                                    </div>

                                </c:when>
                                <c:otherwise>

                                    <div class="header__profileBlock__login">
                                        <a href="${pageContext.request.contextPath}/login">Увійти</a>
                                        <span>|</span>
                                        <a href="${pageContext.request.contextPath}/registration">Зареєструватись</a>
                                    </div>

                                </c:otherwise>

                            </c:choose>

                            <a class="header__profileBlock__descr"
                               href="${pageContext.request.contextPath}/userProfile/">
                                <img class="header__profileBlock__descr_img"
                                     src="${pageContext.request.contextPath}/resources/img/header/profileblack.png"
                                     alt="profile">
                                <div class="header__profileBlock__descr_text">Особистий кабінет</div>
                            </a>

                            <a class="header__profileBlock__descr"
                               href="${pageContext.request.contextPath}/userProfile/userOrders">
                                <img class="header__profileBlock__descr_img"
                                     src="${pageContext.request.contextPath}/resources/img/header/box.png" alt="box">
                                <div class="header__profileBlock__descr_text">Мої замовлення</div>
                            </a>
                        </div>
                    </div>
                    <a class="header__icons_icon" href="${pageContext.request.contextPath}/favoriteProducts">
                        <img class="header__icons_icon_img"
                             src="${pageContext.request.contextPath}/resources/img/header/favorite.png" alt="favorite">
                    </a>
                    <a class="header__icons_icon" href="${pageContext.request.contextPath}/shoppingBag">
                        <img class="header__icons_icon_img"
                             src="${pageContext.request.contextPath}/resources/img/header/basket.png" alt="ShoppingBag">
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="subheader">

        <div class="container">

            <ul id="list" class="subheader__list">

                <%--НОВИНКИ--%>
                <li class="subheader__list__element">

                    <p class="subheader__list__element_text">Новинки</p>
                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list">

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Нове</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/newestClothes?page=1">Дивитись
                                            все</a></li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?newest=true">Одяг</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/footwear?newest=true">Взуття</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/accessories?newest=true">Аксесуари</a>
                                    </li>
                                </ol>
                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Нові підбірки</h2>

                                <ul class="subheader__list__dropdown__list__elem_images">

                                    <c:forEach items="${newestProducts}" var="product" begin="0" end="2">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/brands?brand=${product.brand}&page=1">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.productName}">
                                            <p>${product.brand}</p>
                                            <div class="hoverHeader"></div>

                                        </a>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>

                <%--ОДЯГ--%>
                <li class="subheader__list__element">

                    <p class="subheader__list__element_text">Одяг</p>

                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list ">

                            <li class="subheader__list__dropdown__list__elem subheader__list__dropdown__list__elem_clothes">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за типом продукту</h2>

                                <ol class="subheader__list__dropdown__list__elem_links subheader__list__dropdown__list__elem_links_columns">

                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?page=1">Дивитись
                                            все</a>
                                    </li>
                                    <c:forEach items="${clothesTypes}" var="product">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?productName=${product.productName}&page=1">${product.productName}</a>
                                        </li>

                                    </c:forEach>

                                </ol>

                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <ul class="subheader__list__dropdown__list__elem_images" style="margin-top: 40px;">

                                    <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?page=1">

                                        <img src="${pageContext.request.contextPath}/resources/img/header/man.jpg"
                                             alt="photo"
                                             style="opacity: 0.75;">

                                    </a>

                                    <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?page=1">

                                        <img src="${pageContext.request.contextPath}/resources/img/header/man1.jpg"
                                             alt="photo"
                                             style="opacity: 0.75;">
                                    </a>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>

                <%--ВЗУТТЯ--%>
                <li class="subheader__list__element">

                    <p class="subheader__list__element_text">Взуття</p>

                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list">

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за типом продукту</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/shoes?page=1">Дивитись
                                            все</a>
                                    </li>

                                    <c:forEach items="${shoes}" var="product">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/shoes?productName=${product.productName}&page=1">${product.productName}</a>
                                        </li>

                                    </c:forEach>
                                </ol>

                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за брендом</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <c:forEach items="${shoes}" var="product" begin="0" end="3">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/shoes?brand=${product.brand}&page=1">
                                                <img src="${pageContext.request.contextPath}/${product.image}"
                                                     alt="${product.productName}">
                                                <div>${product.brand}</div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ol>
                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <ul class="subheader__list__dropdown__list__elem_images">

                                    <c:forEach items="${shoes}" var="product" begin="0" end="1">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/shoes?brand=${product.brand}&page=1">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.productName}">
                                            <p>${product.brand}</p>
                                            <div class="hoverHeader"></div>
                                        </a>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>

                <%--АКСЕСУАРИ--%>
                <li class="subheader__list__element">

                    <p class="subheader__list__element_text">Аксесуари</p>

                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list">

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за типом продукту</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/accessories?page=1">Дивитись
                                            все</a>
                                    </li>

                                    <c:forEach items="${accessories}" var="product">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/accessories?productName=${product.productName}&page=1">${product.productName}</a>
                                        </li>

                                    </c:forEach>

                                </ol>

                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за брендом</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <c:forEach items="${accessories}" var="product" begin="0" end="4">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/accessories?brand=${product.brand}&page=1">
                                                <img src="${pageContext.request.contextPath}/${product.image}"
                                                     alt="${product.productName}">
                                                <div>${product.brand}</div>
                                            </a>
                                        </li>

                                    </c:forEach>

                                </ol>

                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <ul class="subheader__list__dropdown__list__elem_images">

                                    <c:forEach items="${accessories}" var="product" begin="0" end="1">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/accessories?brand=${product.brand}&page=1">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.productName}">
                                            <p>${product.brand}</p>
                                            <div class="hoverHeader"></div>

                                        </a>

                                    </c:forEach>

                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>

                <%--СПОРТИВНИЙ ОДЯГ--%>
                <li class="subheader__list__element width">

                    <p class="subheader__list__element_text">Спортивний одяг</p>

                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list">

                            <li class="subheader__list__dropdown__list__elem">

                                <h2 class="subheader__list__dropdown__list__elem_title">Сортувати за типом продукту</h2>

                                <ol class="subheader__list__dropdown__list__elem_links">

                                    <li>
                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/sportWear?page=1">Дивитись
                                            все</a>
                                    </li>

                                    <c:forEach items="${sportWear}" var="product">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/sportWear?productName=${product.productName}&page=1">${product.productName}</a>
                                        </li>

                                    </c:forEach>
                                </ol>
                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <ul class="subheader__list__dropdown__list__elem_images">

                                    <c:forEach items="${sportWear}" var="product" begin="0" end="2">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/sportWear?brand=${product.brand}&page=1">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.productName}">
                                            <p>${product.brand}</p>
                                            <div class="hoverHeader"></div>

                                        </a>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>

                <%--БРЕНДИ--%>
                <li class="subheader__list__element">

                    <p class="subheader__list__element_text">Бренди</p>

                    <div class="subheader__list__dropdown">

                        <ul class="subheader__list__dropdown__list">

                            <li class="subheader__list__dropdown__list__elem subheader__list__dropdown__list__elem_brands">

                                <h2 class="subheader__list__dropdown__list__elem_title">Топ бренди</h2>

                                <ol class="subheader__list__dropdown__list__elem_links subheader__list__dropdown__list__elem_links_columns"
                                    style="column-count: 3;">

                                    <c:forEach items="${brands}" var="product">

                                        <li>
                                            <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/brands?brand=${product.brand}&page=1">${product.brand}</a>
                                        </li>

                                    </c:forEach>

                                </ol>

                            </li>

                            <li class="subheader__list__dropdown__list__elem">

                                <ul class="subheader__list__dropdown__list__elem_images">

                                    <c:forEach items="${brands}" var="product" begin="0" end="1">

                                        <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/brands?brand=${product.brand}&page=1">

                                            <img src="${pageContext.request.contextPath}/${product.image}"
                                                 alt="${product.productName}">
                                            <p>${product.brand}</p>
                                            <div class="hoverHeader"></div>

                                        </a>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</header>

<script>

    let menu = document.querySelector('#profile');
    let menu__wrapper = menu.querySelector('#dropDown');
    let close = menu__wrapper.querySelector('#close');

    let list = document.querySelector('#list');
    let elements = list.querySelectorAll('.subheader__list__element');

    menu.addEventListener('mouseover', () => {
        menu__wrapper.classList.add('active_profile');
        menu__wrapper.style.cursor = 'pointer';
    });

    menu.addEventListener('mouseout', () => {
        menu__wrapper.classList.remove('active_profile');
    });

    close.addEventListener('click', () => {
        menu__wrapper.classList.remove('active_profile');
        menu__wrapper.style.cursor = 'default';
    });

    for (let i = 0; i < elements.length; i++) {

        let element = elements[i];
        let text = element.querySelector('.subheader__list__element_text');
        let dropdown = element.querySelector('.subheader__list__dropdown');
        let overlay = document.querySelector('.over');

        element.addEventListener('mouseover', () => {
            element.classList.add('active_subheader');
            element.style.cursor = 'pointer';
            text.classList.add('active_text');
            dropdown.classList.add('active_dropdown');
            overlay.classList.add('overlayw');

            setInterval(function () {

                let pixels = 130;

                if (window.scrollY < 130)
                    pixels -= window.scrollY;
                else
                    pixels = 0;

                overlay.style.top = pixels;

            }, 1);

        });

        element.addEventListener('mouseout', () => {
            element.classList.remove('active_subheader');
            text.classList.remove('active_text');
            dropdown.classList.remove('active_dropdown');
            overlay.classList.remove('overlayw');
        });

    }

</script>
</body>
</html>