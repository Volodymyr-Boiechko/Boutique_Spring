<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Favorite clothes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clothes.css">
</head>
<body>
<jsp:include page="/header"/>
<c:choose>

    <c:when test="${not empty sessionScope.user}">

        <c:if test="${favoriteProducts.size() != 0}">

            <div class="clothes">

                <div class="container">

                    <div class="row">

                        <c:forEach items="${favoriteProducts}" var="product">

                            <div class="col-md-4">

                                <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem?idProduct=${product.idProduct}">

                                    <div class="clothes__block">

                                        <div class="clothes__block__img">

                                            <img class="clothes__block__img_main"
                                                 src="${pageContext.request.contextPath}${product.image}"
                                                 alt="${product.productName}">

                                            <div class="hover"></div>

                                        </div>

                                        <div class="clothes__block__text">

                                            <div class="clothes__block__text_title">
                                                    ${product.description}
                                            </div>

                                            <div class="clothes__block__text_price">
                                                    ${product.price} грн.
                                            </div>

                                        </div>

                                    </div>
                                </a>

                                <button onclick="deleteFavorite(${product.idProduct})"
                                        class="clothes__block__img__favorite clothes__block__img__favorite_delete">

                                    <img class="clothes__block__img__favorite_deleteImg"
                                         src="${pageContext.request.contextPath}/resources/img/other/delete.png"
                                         alt="favorite">

                                </button>

                                <button class="buttonFavorite">
                                    Добавити в корзину
                                </button>

                            </div>

                        </c:forEach>

                    </div>

                </div>

            </div>

        </c:if>

        <c:if test="${favoriteProducts.size() == 0}">

            <div class="headerFavorite">

                <div class="container">

                    <img src="${pageContext.request.contextPath}/resources/img/other/favorite.png" alt="favorite">
                    <div class="headerFavorite__title">Немає збережених товарів</div>
                    <div class="headerFavorite__descr">
                        Зберігайте товари, які Вам сподобалися в улюблені простим натисканням на сердечко.
                    </div>
                    <a href="${pageContext.request.contextPath}/">Розпочати шопінг</a>

                </div>

            </div>

        </c:if>

    </c:when>
    <c:otherwise>

        <div class="headerFavorite">

            <div class="container">

                <img src="${pageContext.request.contextPath}/resources/img/other/sad_smile.png" alt="sad smile">
                <div class="headerFavorite__descr">
                    Для перегляду улюблених товарів увійдіть у ваш профіль.
                </div>
                <div class="headerFavorite__links">

                    <a href="${pageContext.request.contextPath}/login">Увійти</a>
                    <a href="${pageContext.request.contextPath}/registration">Зареєструватись</a>

                </div>

            </div>

        </div>

    </c:otherwise>

</c:choose>


<jsp:include page="components/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>

    function deleteFavorite(idProduct) {

        let success = false;

        $.ajax({

            url: "/favoriteProducts/" + idProduct,
            async: false,
            method: "DELETE",

        }).done(function (response) {

            success = true;
            console.log(response.status);

            alert("Продукт видалено з улюблених");
            location.reload();

        }).fail(function (response) {

            success = false;

            if (response.status === 500) {
                alert("Виникла помилка на сервері");
            }

        });

        return success;

    }

</script>
</body>
</html>
