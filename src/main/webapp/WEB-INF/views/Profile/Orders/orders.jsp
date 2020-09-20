<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User orders</title>
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

            <div class="orders">

                <div class="orders__block">

                    <div class="orders__block__img">
                        <img src="${pageContext.request.contextPath}/resources/img/profile/box.png" alt="box">
                    </div>
                    <h1 class="orders__block__title">Мої замовлення</h1>

                </div>

                <c:choose>

                    <c:when test="${allOrdersOfUser.size() == 0}">

                        <div class="orders__block">

                            <div class="orders__block__img orders__block__img_notFound">
                                <img src="${pageContext.request.contextPath}/resources/img/other/sad_smile.png" alt="sadSmile">
                            </div>
                            <h1 class="orders__block__title orders__block__title_notFound">Замовлень не знайдено</h1>

                        </div>

                    </c:when>
                    <c:otherwise>

                        <c:forEach var="entry" items="${allOrdersOfUser}">

                            <div class="orders__block">

                                <div class="orders__block__text">

                                    <div class="orders__block__text_descr">
                                        <span>Замовлення №:</span><br>
                                            ${entry.key.idOrder}
                                    </div>

                                    <div class="orders__block__text_descr">
                                        <span>Дата замовлення:</span><br>
                                            ${entry.key.orderTime}
                                    </div>

                                </div>

                                <div class="orders__block__info">

                                    <div class="orders__block__info__images">

                                        <c:forEach var="listEl" items="${entry.value}" begin="0" end="2" varStatus="theCount">

                                            <a id="link"
                                               href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem/${listEl.idProduct}"
                                               class="orders__block__info__images_img">
                                                <c:if test="${theCount.count == 3 && entry.value.size() > 3}">

                                                    <div class="hover">
                                                        <div class="hover__plus">+${entry.value.size() - 3}</div>
                                                    </div>

                                                </c:if>
                                                <img src="${pageContext.request.contextPath}/resources/${listEl.image}"
                                                     alt="${listEl.typeName}">
                                            </a>

                                        </c:forEach>

                                    </div>
                                    <div class="orders__block__info__button">
                                        <a href="${pageContext.request.contextPath}/userProfile/userOrders/${entry.key.idOrder}"
                                           class="button button_orders">Переглянути замовлення</a>
                                    </div>

                                </div>

                            </div>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

            </div>

        </div>

    </div>

</div>
<jsp:include page="../../components/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
        crossorigin="anonymous"></script>
<script>

    let blocks = document.querySelectorAll('.orders__block');

    for (let i = 1; i < blocks.length; i++) {

        let images = blocks[i].querySelectorAll('#link');
        let hover = blocks[i].querySelector('.hover');

        if (images.length === 3 && hover !== null) {

            hover.style.display = "block";

            let button = blocks[i].querySelector('.button_orders');

            images[2].href = button.href;

        }

    };

</script>
</body>
</html>
