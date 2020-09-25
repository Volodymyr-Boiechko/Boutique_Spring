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

            <div class="headerClothes__title">На жаль, такого типу продукту не знайдено</div>

            <div class="headerClothes__descr"></div>

        </div>

    </c:when>
    <c:otherwise>

        <div class="pathBlock">

            <div class="container">

                <div class="pathBlock__productPath">

                    <a class="pathBlock__productPath__info" href="${pageContext.request.contextPath}/">
                        Головна сторінка
                    </a>
                    <div class="pathBlock__productPath_divider">›</div>
                    <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}"
                       class="pathBlock__productPath__info">
                            ${sex}
                    </a>
                    <div class="pathBlock__productPath_divider">›</div>
                    <div class="pathBlock__productPath__info">${productName}</div>

                </div>

            </div>

        </div>

        <jsp:include page="/clothesFilter"/>

        <div class="clothes">

            <div class="container">

                <div>

                    <div class="row">

                        <c:forEach items="${sessionScope.clothes}" begin="0" end="${numberOfProductsShownOnPage - 1}"
                                   var="product">

                            <div class="block col-md-4" id="${product.idProduct}">

                                <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem/${product.idProduct}">

                                    <div class="clothes__block">

                                        <div class="clothes__block__img">

                                            <img class="clothes__block__img_main"
                                                 src="${pageContext.request.contextPath}/resources/${product.image}"
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

                                <button onclick="addToFavorite(${product.idProduct})"
                                        class="clothes__block__img__favorite">

                                    <img class="clothes__block__img__favorite_img" id="favorite"
                                         src="${pageContext.request.contextPath}/resources/img/other/favorite.png"
                                         alt="favorite">

                                </button>

                            </div>

                        </c:forEach>

                        <c:if test="${not empty sessionScope.user}">

                            <c:if test="${isUserCanAddClothes}">

                                <div class="col-md-4">

                                    <div class="clothes__block" style="border: 0.5px grey solid;">

                                        <button name="addButton" class="clothes__block__addButton" id="addButton">

                                            <img src="${pageContext.request.contextPath}/resources/img/other/add.jpg"
                                                 alt="add">

                                        </button>

                                    </div>

                                </div>

                            </c:if>

                        </c:if>

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

<div id="modalAddClothes"></div>

<jsp:include page="components/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins/MultipleSelect.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/plugins/PluginForMultipleSelect.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addToFavorite.js"></script>
<script charset="utf-8">

    let array = ${sessionScope.idsOfProductsThatAreFavorite};

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

        let page = ${pageNumber} +1;

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

    let isUserAdmin = ${isUserCanAddClothes};

    if (isUserAdmin === true) {

        $(document).ready(function () {

            $('#addButton').on('click', function () {
                $('#addOverlay, #add').fadeIn('slow');
            });

            $('.modalw__close').on('click', function () {
                $('#addOverlay, #add, #thanks').fadeOut('slow');
                location.reload();
            });

        });

        let typeName, productName, sex;

        <c:if test="${sessionScope.clothes.size() != 0}">
        typeName = "${sessionScope.clothes.get(0).typeName}";
        productName = "${sessionScope.clothes.get(0).productName}";
        sex = "${sessionScope.clothes.get(0).sex}";
        </c:if>


        document.getElementById("modalAddClothes").innerHTML =
            "<div class=\"overlay\" id=\"addOverlay\">\n" +
            "    <div class=\"modalw modalw_call modalw_addProduct\" id=\"add\">\n" +
            "        <div class=\"modalw__close modalw__close_call\">&times;</div>\n" +
            "        <form id=\"addClothesForm\" class=\"feed-form\">\n" +
            "\n" +
            "            <ul>\n" +
            "                <div class=\"feed-form__title\">Заповніть поля для добавлення<br> товару на сайт</div>\n" +
            "                <li class=\"top\">\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"type\" placeholder=\"Тип товару\" type=\"text\" value=\"" + typeName + "\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"product\" placeholder=\"Підтип товару\" value=\"" + productName + "\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"sex\" placeholder=\"Стать(чоловік/жінка)\" value=\"" + sex + "\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"brand\" placeholder=\"Бренд товару\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input name=\"model\" class=\"input\" id=\"model\" placeholder=\"Модель товару(не обов'язково)\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"size\" placeholder=\"Розмір товару(не обов'язково)\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"color\" placeholder=\"Колір товару(не обов'язково)\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"image\" placeholder=\"Зображення\" type=\"file\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"destination\" placeholder=\"Де повинен зберігатись файл\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <label>\n" +
            "                        <input class=\"input\" id=\"price\" placeholder=\"Ціна товару\" type=\"text\">\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li style=\"height: 85px;\">\n" +
            "                    <label>\n" +
            "                        <textarea class=\"input input_com\" id=\"description\" placeholder=\"Опис товару\"></textarea>\n" +
            "                    </label>\n" +
            "                </li>\n" +
            "\n" +
            "                <li>\n" +
            "                    <button id=\"button\" class=\"modalw__button\">Добавити до бази</button>\n" +
            "                </li>\n" +
            "\n" +
            "            </ul>\n" +
            "\n" +
            "        </form>\n" +
            "    </div>\n" +
            "    <div class=\"modalw modalw_mini\" id=\"thanks\">\n" +
            "        <div class=\"modalw__close\">&times;</div>\n" +
            "        <div class=\"modalw__subtitle\">Продукт добавлено</div>\n" +
            "    </div>\n" +
            "</div>";

        document.getElementById("addClothesForm").onsubmit = function (e) {

            e.preventDefault();

            $.ajax({

                url: "/clothes",
                async: false,
                type: "POST",
                processData: false,
                cache: false,
                contentType: false,
                data: formData()

            }).done(function (response) {

                console.log(response.status);

                $('#add').fadeOut('fast');
                $('#thanks').fadeIn('slow');
                $('#addForm').trigger('reset');

            }).fail(function (response) {

                console.log(response.status);

                if (response.status === 500) {
                    alert("Виникла помилка на сервері");
                } else if (response.status === 501) {
                    alert("Не вдалось зберегти зображення");
                }

            });

        };

        function formData() {

            let formData = new FormData();

            formData.append("image", document.getElementById('image').files[0]);
            formData.append("typeName", document.getElementById('type').value);
            formData.append("productName", document.getElementById('product').value);
            formData.append("sex", document.getElementById('sex').value);
            formData.append("brand", document.getElementById('brand').value);
            formData.append("model", document.getElementById('model').value);
            formData.append("size", document.getElementById('size').value);
            formData.append("color", document.getElementById('color').value);
            formData.append("destination", document.getElementById('destination').value);
            formData.append("price", document.getElementById('price').value);
            formData.append("description", document.getElementById('description').value);

            return formData;

        }

    }

</script>
</body>
</html>