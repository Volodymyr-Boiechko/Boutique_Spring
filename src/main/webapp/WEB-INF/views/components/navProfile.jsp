<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Nav Profile</title>
</head>
<body>
<nav class="profile__nav">

    <ul class="profile__nav__list" id="NavList">

        <li class="profile__nav__list__element headerBlock" style="margin-top: 0;">

            <div class="headerBlock__image">${firstLetterOfUsername}</div>

            <div class="headerBlock__text">Привіт,<br><span>${sessionScope.user.username}</span></div>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/userProfile/"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/profile.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Перегляд особистого профілю</p>

            </a>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/userProfile/userOrders"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/box.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Мої замовлення</p>

            </a>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/userProfile/userInfo"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/info.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Моя інформація</p>

            </a>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/userProfile/changePassword"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/changePassword.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Змінити пароль</p>

            </a>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/userProfile/userAddresses"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/address.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Мої адреси</p>

            </a>

        </li>

        <li class="profile__nav__list__element">

            <a href="${pageContext.request.contextPath}/logout"
               class="profile__nav__list__element__block">

                <img class="profile__nav__list__element__block_icon"
                     src="${pageContext.request.contextPath}/resources/img/profile/logout.png"
                     alt="profile">
                <p class="profile__nav__list__element__block_text">Вийти з профілю</p>

            </a>

        </li>
    </ul>
</nav>
<script>

    let navList = document.querySelector("#NavList");
    let elementsLi = navList.querySelectorAll(".profile__nav__list__element");

    let elementLi = elementsLi[${numberOfSectionInNavigationBar}];

    elementLi.classList.add('active_element');

</script>
</body>
</html>
