<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Clothes</title>
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

    <c:when test="${sessionScope.clothes.size() == 0}">

        <div class="headerClothes">

            <img src="${pageContext.request.contextPath}/resources/img/other/sad_smile.png" alt="sadSmile">

            <div class="headerClothes__title">На жаль такого типу продукту не знайдено</div>

            <div class="headerClothes__descr"></div>

        </div>

    </c:when>
    <c:otherwise>

        <div class="clothes">

            <div class="container">

                <div>

                    <div class="row">

                        <c:forEach items="${sessionScope.clothes}" begin="0" end="${lastIndexOfShownProduct}"
                                   var="product">

                            <div class="block col-md-4" id="${product.idProduct}">

                                <a href="${pageContext.request.contextPath}/manClothes/productItem?idProduct=${product.idProduct}">

                                    <div class="clothes__block">

                                        <div class="clothes__block__img">

                                            <img class="clothes__block__img_main"
                                                 src="${pageContext.request.contextPath}/${product.image}"
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

                                <button onclick="addToFavorite(${product.idProduct})" class="clothes__block__img__favorite">

                                    <img class="clothes__block__img__favorite_img" id="favorite"
                                         src="${pageContext.request.contextPath}/resources/img/other/favorite.png"
                                         alt="favorite">

                                </button>

                            </div>

                        </c:forEach>

                    </div>

                </div>

                <div class="clothes__more">

                    <div class="clothes__more_title">Ви переглянули ${numberOfProductsShownOnPage}
                        із ${sessionScope.clothes.size()} товарів
                    </div>

                    <c:if test="${sessionScope.clothes.size() != numberOfProductsShownOnPage}">

                        <button onclick="morePages()" class="clothes__more__downloadMore">Загрузити ще</button>

                    </c:if>

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

    let array = ${idsOfProductsThatAreFavorite};

    setInterval(function () {

        let blocks = document.querySelectorAll('.block');

        for (let i = 0; i < blocks.length; i++) {

            let id = blocks[i].getAttribute('id');

            for (let j = 0; j < array.length; j++) {

                if (parseInt(id) === array[j]) {

                    let img = blocks[i].querySelector('#favorite');
                    img.src = "${pageContext.request.contextPath}/resources/img/other/favoriteFull.png";
                    break;

                }
            }
        }
    }, 1);

    function morePages() {

        let page = ${pageNumber} + 1;

        let href = window.location.href;

        if (href.includes("page=") === false) {
            window.location.href = href.concat("&page=" + page);
        } else {
            window.location.href = href.replace('page=${pageNumber}', 'page=' + page);
        }

    }

    document.addEventListener("DOMContentLoaded", function () {
        let scrollPos = localStorage.getItem('scrollPos');
        if (scrollPos) window.scrollTo(0, scrollPos);
    });

    window.onbeforeunload = function (e) {
        localStorage.setItem('scrollPos', window.scrollY);
    };

</script>
</body>
</html>