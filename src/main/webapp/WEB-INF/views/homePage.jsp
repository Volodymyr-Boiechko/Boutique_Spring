<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Boutique</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/homePage.css">
</head>
<body>
<jsp:include page="/header"/>

<div class="allTypes">

    <div class="container">

        <div class="row">

            <div class="col-md-6">

                <div class="allTypes__block">

                    <a href="${pageContext.request.contextPath}/manClothes/newestClothes?page=1">
                        <img class="allTypes__block_image"
                             src="${pageContext.request.contextPath}/resources/img/homePage/newest.jpg" alt="shoes">
                    </a>

                    <div class="allTypes__block__text">

                        <div class="allTypes__block__text_title">Новинки</div>

                        <div class="allTypes__block__text_descr">Залишайтесь постійно в трендах моди</div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">

                <div class="allTypes__block">

                    <a href="${pageContext.request.contextPath}/manClothes/clothes?page=1">
                        <img class="allTypes__block_image"
                             src="${pageContext.request.contextPath}/resources/img/homePage/clothes.png" alt="clothes">
                    </a>

                    <div class="allTypes__block__text">

                        <div class="allTypes__block__text_title">Одяг</div>

                        <div class="allTypes__block__text_descr">Найновіші колекції</div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mt-5">

                <div class="allTypes__block">

                    <a href="${pageContext.request.contextPath}/manClothes/shoes?page=1">
                        <img class="allTypes__block_image"
                             src="${pageContext.request.contextPath}/resources/img/homePage/sneakers.jpg" alt="shoes">
                    </a>

                    <div class="allTypes__block__text">

                        <div class="allTypes__block__text_title">Взуття</div>

                        <div class="allTypes__block__text_descr">Nike, adidas та багато інших брендів</div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mt-5">

                <div class="allTypes__block">

                    <a href="${pageContext.request.contextPath}/manClothes/accessories?page=1">
                        <img class="allTypes__block_image"
                             src="${pageContext.request.contextPath}/resources/img/homePage/accessories.jpg"
                             alt="shoes">
                    </a>

                    <div class="allTypes__block__text">

                        <div class="allTypes__block__text_title">Аксесуари</div>

                        <div class="allTypes__block__text_descr">Доповніть ваш образ</div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div class="brands">

    <div class="container">

        <div class="brands__title">Популярні бренди</div>

        <ul class="brands__list">

            <li class="brands__list__element">
                <a href="${pageContext.request.contextPath}/manClothes/brands?brand=The North Face&page=1">
                    <img class="brands__list__element_img"
                         src="${pageContext.request.contextPath}/resources/img/homePage/brands/north-face.png"
                         alt="North-Face">
                </a>
            </li>

            <li class="brands__list__element" style="padding-top: 37px;">
                <a href="${pageContext.request.contextPath}/manClothes/brands?brand=Lacoste&page=1">
                    <img class="brands__list__element_img"
                         src="${pageContext.request.contextPath}/resources/img/homePage/brands/lacoste.png"
                         alt="Lacoste">
                </a>
            </li>

            <li class="brands__list__element" style="padding-top: 45px;">
                <a href="${pageContext.request.contextPath}/manClothes/brands?brand=Nike&page=1">
                    <img class="brands__list__element_img"
                         src="${pageContext.request.contextPath}/resources/img/homePage/brands/nike.png" alt="Nike">
                </a>
            </li>

            <li class="brands__list__element">
                <a href="${pageContext.request.contextPath}/manClothes/brands?brand=Tommy Hilfiger&page=1">
                    <img class="brands__list__element_img"
                         src="${pageContext.request.contextPath}/resources/img/homePage/brands/tommy-hilfiger.png"
                         alt="Tommy-Hilfiger">
                </a>
            </li>

            <li class="brands__list__element" style="padding-top: 20px;">
                <a href="${pageContext.request.contextPath}/manClothes/brands?brand=Louis Vuitton&page=1">
                    <img class="brands__list__element_img"
                         src="${pageContext.request.contextPath}/resources/img/homePage/brands/louis-vuitton.png"
                         alt="Louis-Vuitton">
                </a>
            </li>
        </ul>

    </div>

</div>

<%--<jsp:include page="jsp-pages/components/footer.jsp"/>--%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>

</body>
</html>