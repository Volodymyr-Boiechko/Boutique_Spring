<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clothes.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
</head>
<body>
<jsp:include page="/header"/>

<div class="container">

    <div class="path">

        <a class="path__info" href="${pageContext.request.contextPath}/">Головна сторінка</a>
        <div class="path_divider">›</div>
        <div class="path__info">${pathToProduct.get(0)}</div>
        <div class="path_divider">›</div>
        <a class="path__info"
           href="${pageContext.request.contextPath}/manClothes/${pathToProduct.get(1)}?page=1">${product.typeName}</a>
        <div class="path_divider">›</div>
        <a class="path__info"
           href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/clothes?productName=${product.productName}&page=1">${product.productName}</a>
        <div class="path_divider">›</div>
        <div class="path__info">${product.description}</div>

    </div>

</div>

<div class="product" id="${product.idProduct}">

    <div class="container">

        <div class="row">

            <div class="col-md-5 offset-md-1">

                <div class="product__image">

                    <img src="${pageContext.request.contextPath}/resources/${product.image}" alt="${product.productName}">

                </div>

            </div>

            <div class="col-md-6">

                <div class="product__blockInfo">

                    <div class="product__blockInfo">

                        <h1 class="product__blockInfo_title">${product.description}</h1>
                        <h2 class="product__blockInfo_price">${product.price} грн.</h2>

                        <c:if test="${not empty product.model}">
                            <div class="product__blockInfo__character">

                                <div class="product__blockInfo__character_title">
                                    Модель:
                                </div>

                                <div class="product__blockInfo__character_descr">
                                        ${product.model}
                                </div>

                            </div>
                        </c:if>

                        <c:if test="${not empty product.size}">
                            <div class="product__blockInfo__character">

                                <div class="product__blockInfo__character_title">
                                    Розмір:
                                </div>

                                <div class="product__blockInfo__character_descr">
                                        ${product.size}
                                </div>

                            </div>
                        </c:if>

                        <c:if test="${not empty product.color}">
                            <div class="product__blockInfo__character">

                                <div class="product__blockInfo__character_title">
                                    Колір:
                                </div>

                                <div class="product__blockInfo__character_descr">
                                        ${product.color}
                                </div>

                            </div>
                        </c:if>

                        <div class="product__blockInfo__buttons">

                            <button onclick="addToShoppingBag(${product.idProduct})"
                                    class="product__blockInfo__buttons_addToBasket">Добавити в корзину
                            </button>

                            <button onclick="addToFavorite(${product.idProduct})"
                                    class="product__blockInfo__buttons_favorite">
                                <img id="favorite"
                                     src="${pageContext.request.contextPath}/resources/img/other/favorite.png"
                                     alt="favorite">
                            </button>

                        </div>


                    </div>

                </div>

            </div>

        </div>

        <div class="productLine"></div>

    </div>

</div>

<div class="mayLike">

    <div class="container">

        <h1 class="mayLike__title">Можливо вам також сподобається</h1>

        <div class="row">

            <div class="offset-md-2"></div>

            <c:forEach items="${productsThatUserMayLike}" var="product">

                <div class="block col-md-2">

                    <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem/${product.idProduct}">

                        <div class="clothes__block clothes__block_mini">

                            <div class="clothes__block__img clothes__block__img_mini">

                                <img class="clothes__block__img_main"
                                     src="${pageContext.request.contextPath}/resources/${product.image}"
                                     alt="${product.productName}">

                                <div class="hover"></div>

                            </div>

                            <div class="clothes__block__text">

                                <div class="clothes__block__text_title clothes__block__text_title_mini">
                                        ${product.description}
                                </div>

                                <div class="clothes__block__text_price clothes__block__text_price_mini">
                                        ${product.price} грн.
                                </div>

                            </div>

                        </div>
                    </a>

                </div>

            </c:forEach>

        </div>

    </div>

</div>

<jsp:include page="components/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/addToFavorite.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addToShoppingBag.js"></script>
<script>

    let array = ${sessionScope.idsOfProductsThatAreFavorite};

    setInterval(function () {

        let id = ${product.idProduct};

        for (let j = 0; j < array.length; j++) {

            if (parseInt(id) === array[j]) {

                let img = document.querySelector('#favorite');
                img.src = "/resources/img/other/favoriteFull.png";
                break;

            }
        }

    }, 100);

</script>
</body>
</html>
