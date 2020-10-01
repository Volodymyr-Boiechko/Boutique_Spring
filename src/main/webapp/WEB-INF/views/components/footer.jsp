<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Footer</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <script src="https://kit.fontawesome.com/68f4b014b0.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>

<footer class="footer">

    <div class="container">

        <div class="row">

            <h1 class="title">Безпечні онлайн платежі</h1>

            <div class="col-md-2 offset-md-3"><img class="pay" src="${pageContext.request.contextPath}/resources/img/footer/visa.png" alt="visa"></div>
            <div class="col-md-2"><img class="pay" src="${pageContext.request.contextPath}/resources/img/footer/masterCard.png" alt="masterCard"></div>
            <div class="col-md-2"><img class="pay" src="${pageContext.request.contextPath}/resources/img/footer/paypal.png" alt="paypal"></div>

            <div class="line"></div>

            <div class="col-md-5">

                <h2 class="footer__title">Потрібна допомога?</h2>

                <button id="application" class="button button_footer">Залишити заяву</button>

                <div class="footer__number">У разі необхідності зателефонуйте нам по телефону
                    <a href="tel:8800000800"> 8 800 000 800</a>
                </div>

                <div class="footer__text">
                    Понеділок - п'ятниця з 8:00 до 20:00 за київським часом <br>
                    Субота - неділя з 10:00 до 18:00 за київським часом
                </div>

            </div>

            <div class="col-md-4">

                <h2 class="footer__title center">Інформація про покупки</h2>

                <div class="footer__info">
                    <ul class="footer__list">
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/shoppingGuide?section=general-info">
                                Загальна інформація
                            </a>
                        </li>
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/shoppingGuide?section=payment">
                                Спосіб оплати
                            </a>
                        </li>
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/shoppingGuide?section=shipping">
                                Доставка
                            </a>
                        </li>
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/shoppingGuide?section=orders-returns">
                                Повернення товару
                            </a>
                        </li>
                    </ul>
                </div>

            </div>

            <div class="col-md-3">
                <h2 class="footer__title center">Про Boutique</h2>

                <div class="footer__info">
                    <ul class="footer__list">
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/company?section=aboutUs">
                                Про нас
                            </a>
                        </li>
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/company?section=offices">
                                Офіси
                            </a>
                        </li>
                        <li class="footer__list_element">
                            <a href="${pageContext.request.contextPath}/shoppingGuide?section=policy">
                                Політика магазину
                            </a>
                        </li>
                    </ul>
                </div>

            </div>

            <div class="line"></div>

            <h1 class="title">Приєднуйся до нас</h1>

            <div class="social">
                <a href="https://www.facebook.com" class="social__item"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.instagram.com" class="social__item"><i class="fab fa-instagram"></i></a>
                <a href="https://twitter.com" class="social__item"><i class="fab fa-twitter"></i></a>
            </div>

            <div class="line"></div>

            <div class="footer__bottom">

                <div class="footer__bottom_brand">© 2020 Boutique</div>
                <a class="footer__bottom_link" href="#">Політика використання Cookies</a>
                <a class="footer__bottom_link leftFooter" href="#">Політика конфіденційності</a>

            </div>

        </div>
    </div>
</footer>

<div class="overlay" id="footerOverlay">
    <div class="modalw modalw_call" id="call">
        <div class="modalw__close modalw__close_call">&times;</div>
        <form id="questionForm" class="feed-form">

            <ul>
                <li class="titles">
                    <div class="feed-form__title">Просто заповніть форму заявки</div>
                </li>
                <li class="titles">
                    <div class="feed-form__descr">Ви можете залишити своє повідомлення тут, і ми відповімо при першій же можливості</div>
                </li>
                <li>
                    <label>
                        <input class="input" id="firstName" name="name" placeholder="Ім'я" type="text">
                    </label>
                </li>

                <li>
                    <label>
                        <input class="input" id="surname" name="name" placeholder="Прізвище">
                    </label>
                </li>

                <li>
                    <label>
                        <input class="input" id="email" name="email" placeholder="Електронна-пошта">
                    </label>
                </li>

                <li>
                    <label>
                        <input class="input" id="phoneNumber" name="phone" placeholder="Мобільний телефон">
                    </label>
                </li>

                <li style="height: 85px;">
                    <label>
                        <textarea class="input input_com" id="comment" name="comment" placeholder="Коментар"></textarea>
                    </label>
                </li>

                <li>
                    <button type="submit" id="button" class="modalw__button">Відправити запит</button>
                </li>

            </ul>

        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

    $(document).ready(function () {

        $('#application').on('click', function () {
            $('#footerOverlay, #call').fadeIn('slow');
        });

        $('.modalw__close').on('click', function () {
            $('#footerOverlay, #call, #thanks').fadeOut('slow');
        });

    });

    document.getElementById("questionForm").onsubmit = function (e) {

        e.preventDefault();

        $.ajax({

            url: "/footer",
            async: false,
            type: "POST",
            data: {

                firstName: document.getElementById('firstName').value,
                surname: document.getElementById('surname').value,
                email: document.getElementById('email').value,
                phoneNumber: document.getElementById('phoneNumber').value,
                comment: document.getElementById('comment').value

            }
        }).done(function () {

            $('#call').fadeOut('fast');

            document.getElementById("footerOverlay").innerHTML =
                "    <div class=\"modalw modalw_mini\" id=\"thanks\">\n" +
                "        <div class=\"modalw__close\">&times;</div>\n" +
                "        <div class=\"modalw__subtitle\">Повідомлення відправлено</div>\n" +
                "        <div class=\"modalw__descr\">\n" +
                "            Відповідь буде відправлено на вказану пошту або номер телефону.\n" +
                "        </div>\n" +
                "    </div>";

            $(document).ready(function () {

                $('.modalw__close').on('click', function () {
                    $('#footerOverlay, #call, #thanks').fadeOut('slow');
                });

            });

            $('#thanks').fadeIn('slow');
            $('#form').trigger('reset');

        });

    };


</script>
</body>
</html>
