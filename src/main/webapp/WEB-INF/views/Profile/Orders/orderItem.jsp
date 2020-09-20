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

            <div class="orderItem">

                <div class="orderItem__block">

                    <div class="orderItem__block__infoOrder">

                        <div class="orderItem__block__infoOrder__img">
                            <img src="${pageContext.request.contextPath}/resources/img/profile/box.png" alt="box">
                        </div>

                        <div class="orderItem__block__infoOrder__title">Інформація про замовлення</div>

                        <div class="orderItem__block__infoOrder__descr">Привіт ${sessionScope.user.username}, Ваше
                            замовлення отримано. Ознайомтесь з деталями нижче
                        </div>

                        <div class="orderItem__block__infoOrder__text">

                            <div class="orderItem__block__infoOrder__text__info">
                                Замовлення №
                                <div class="orderItem__block__infoOrder__text__info_orderDetail orderItem__block__infoOrder__text__info_orderDetail_more">${order.idOrder}</div>
                            </div>
                            <div class="orderItem__block__infoOrder__text__info">
                                Дата замовлення
                                <div class="orderItem__block__infoOrder__text__info_orderDetail">${order.orderTime}</div>
                            </div>

                        </div>

                    </div>

                </div>

                <div class="orderItem__block">

                    <div class="orderItem__block__products">

                        <div class="orderItem__block__products__title">
                            ${orderProducts.size()}
                            <c:if test="${orderProducts.size() == 1}"> товар</c:if>
                            <c:if test="${orderProducts.size() > 1 && orderProducts.size() <= 4}"> товари</c:if>
                            <c:if test="${orderProducts.size() > 4}"> товарів</c:if>
                        </div>

                        <c:forEach items="${orderProducts}" var="product">

                            <div class="orderItem__block__products__block">

                                <a href="${pageContext.request.contextPath}/clothes/${sessionScope.sex}/productItem/${product.idProduct}"
                                   class="orderItem__block__products__block__img">
                                    <img src="${pageContext.request.contextPath}/resources/${product.image}"
                                         alt="${product.typeName}">
                                </a>

                                <div class="orderItem__block__products__block__text">

                                    <div class="orderItem__block__products__block__text_descr">${product.description}</div>
                                    <div class="orderItem__block__products__block__text_price">${product.price} грн.
                                    </div>

                                    <div class="orderItem__block__products__block__text__char">

                                        <c:if test="${not empty product.model}">

                                            <div class="orderItem__block__products__block__text__char__label">

                                                <div class="orderItem__block__products__block__text__char__label_title">
                                                    Модель
                                                </div>
                                                <div class="orderItem__block__products__block__text__char__label_info">${product.model}</div>

                                            </div>

                                        </c:if>

                                        <c:if test="${not empty product.color}">

                                            <div class="orderItem__block__products__block__text__char__label">

                                                <div class="orderItem__block__products__block__text__char__label_title">
                                                    Колір:
                                                </div>
                                                <div class="orderItem__block__products__block__text__char__label_info">${product.color}</div>

                                            </div>

                                        </c:if>

                                        <c:if test="${not empty product.size}">

                                            <div class="orderItem__block__products__block__text__char__label">

                                                <div class="orderItem__block__products__block__text__char__label_title">
                                                    Розмір:
                                                </div>
                                                <div class="orderItem__block__products__block__text__char__label_info">${product.size}</div>

                                            </div>

                                        </c:if>

                                        <div class="orderItem__block__products__block__text__char__label">

                                            <div class="orderItem__block__products__block__text__char__label_title">
                                                Кількість:
                                            </div>
                                            <div class="orderItem__block__products__block__text__char__label_info">${product.quantity}</div>

                                        </div>

                                    </div>


                                </div>

                            </div>

                        </c:forEach>

                        <div class="orderItem__block__products__totalPrice">

                            <div class="orderItem__block__products__totalPrice__textTotal">

                                <div class="orderItem__block__products__totalPrice__textTotal_el">
                                    Проміжний підсумок<span>${order.totalPrice} грн.</span>
                                </div>
                                <div class="orderItem__block__products__totalPrice__textTotal_el">
                                    Доставка<span>Безкоштовно</span>
                                </div>

                            </div>

                            <div class="orderItem__block__products__totalPrice__total">
                                Загальна сума<span>${order.totalPrice} грн.</span>
                            </div>

                        </div>

                    </div>

                </div>

                <div class="orderItem__block">

                    <div class="orderItem__block__address">

                        <div class="orderItem__block__address__title">Деталі доставки</div>

                        <div class="orderItem__block__address__block">

                            <div class="orderItem__block__address__block__title">Адрес доставки:</div>

                            <div class="orderItem__block__address__block_element">${sessionScope.user.firstName} ${sessionScope.user.surname}</div>
                            <div class="orderItem__block__address__block_element">${address.street}</div>
                            <div class="orderItem__block__address__block_element">${address.city}</div>
                            <div class="orderItem__block__address__block_element">${address.country}</div>
                            <div class="orderItem__block__address__block_element">${address.postCode}</div>
                            <div class="orderItem__block__address__block_element">${sessionScope.user.phoneNumber}</div>

                            <div class="orderItem__block__address__block__title">Передбачувана дата доставки:</div>
                            <div class="orderItem__block__address__block_element">${order.orderTime.toLocalDate().plusDays(21)}</div>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>
<jsp:include page="../../components/footer.jsp"/>
</body>
</html>
