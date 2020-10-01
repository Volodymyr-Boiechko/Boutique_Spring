<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Filter</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
          integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,400;0,500;0,700;1,300&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap-reboot.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/filters.css">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>
<body>

<section class="filters">

    <div class="container">

        <ul class="filters__list">

            <select id="sort"></select>
            <select id="sizes"></select>
            <select id="brands"></select>
            <select id="colors"></select>


            <li class="filter">
                <button class="dropdownButton dropdownButton__prices">
                    <div class="dropdownButton__text">Ціна</div>
                </button>
                <div class="dropdown-content hidden">
                    <div class="headerFilter">
                        <div class="headerFilter__text" id="headerMin">Вибраний ціновий діапазон</div>
                        <div class="headerFilter__prices">
                            <div id="minPriceHeader">${minPrice} грн</div>
                            -
                            <div id="maxPriceHeader">${maxPrice} грн</div>
                        </div>
                        <button class="headerFilter__button" id="resetPrices">Очистити</button>
                    </div>
                    <div class="middle">
                        <div class="prices">
                            <div class="prices__min" id="minPrice">${minPrice} грн</div>
                            <div class="prices__max" id="maxPrice">${maxPrice} грн</div>
                        </div>
                        <div class="multi-range-slider">
                            <input type="range" id="input-left" min="${minPrice}" max="${maxPrice}" value="${minPrice}">
                            <input type="range" id="input-right" min="${minPrice}" max="${maxPrice}"
                                   value="${maxPrice}">

                            <div class="slider">
                                <div class="track"></div>
                                <div class="range"></div>
                                <div class="thumb left"></div>
                                <div class="thumb right"></div>
                            </div>

                        </div>
                    </div>
                </div>
            </li>
        </ul>

    </div>

</section>
<script src="${pageContext.request.contextPath}/resources/js/filters/LoadAndGetDataFromSelect.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/filters/slider.js"></script>
<script>

    //created arrays and create multi select
    $(document).ready(function () {

        let idBrand = 1;
        let brands = [
            <c:forEach items="${brands}" var="brand">
            {id: idBrand++, brand: "${brand}"},
            </c:forEach>
        ];

        loadData("brands", brands, "brand", "Бренди");

        let idColor = 1;
        let colors = [
            <c:forEach items="${colors}" var="color">
            <c:if test="${color != ''}">
            {id: idColor++, color: "${color}"},
            </c:if>
            </c:forEach>
        ];

        loadData("colors", colors, "color", "Колір");

        let idSize = 1;
        let sizes = [
            <c:forEach items="${sizes}" var="size">
            {id: idSize++, size: "${size}"},
            </c:forEach>
        ];

        loadData("sizes", sizes, "size", "Розмір");

        let sort = [{id: 1, name: "Новинки"}, {id: 2, name: "Сортувати за зростанням"},
            {id: 3, name: "Сортувати за спаданням"}];

        loadData("sort", sort, "name", "Сортувати");

        // if user selected filter
        $(".list__el").on('click', function (e) {

            let list__el = $(this);

            if (list__el.hasClass('selected') === false) {
                list__el.toggleClass('selected');
            } else {
                list__el.removeClass('selected');
            }

            let selectedBrands = getSelectedBrands(null);
            let selectedColors = getSelectedColors(null);
            let selectedSizes = getSelectedSizes(null);
            let minPrice = getLeftValue();
            let maxPrice = getRightValue();

            filterData(selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        });

        $(".headerFilter__button").on('click', function (e) {

            let $wrap = $(this).closest('.filter');
            let filter = $wrap.find('select').attr("id");

            let selectedBrands = getSelectedBrands(filter);
            let selectedColors = getSelectedColors(filter);
            let selectedSizes = getSelectedSizes(filter);
            let minPrice = getLeftValue();
            let maxPrice = getRightValue();

            filterData(selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        });

    });

    //if user moved slider
    $("#input-left, #input-right").on('input change', function () {

        $(".dropdownButton__prices").attr('style', "border-top: 2px solid #0770cf");

        let minPrice = ${minPrice};
        let maxPrice = ${maxPrice};

        let minPriceSelected = getLeftValue();
        let maxPriceSelected = getRightValue();

        if (minPrice === parseInt(minPriceSelected) && maxPrice === parseInt(maxPriceSelected)) {
            $(".dropdownButton__prices").removeAttr('style');
        }

        let selectedBrands = getSelectedBrands(null);
        let selectedColors = getSelectedColors(null);
        let selectedSizes = getSelectedSizes(null);

        filterData(selectedBrands, selectedColors, selectedSizes, minPriceSelected, maxPriceSelected);

    });

    //reset slider values
    $("#resetPrices").on('click', function () {
        document.getElementById('minPrice').innerHTML = ${minPrice} + " грн";
        document.getElementById('minPriceHeader').innerHTML = ${minPrice} + " грн";
        document.getElementById('maxPrice').innerHTML = ${maxPrice} + " грн";
        document.getElementById('maxPriceHeader').innerHTML = ${maxPrice} + " грн";

        let inputLeft = document.getElementById('input-left');
        let inputRight = document.getElementById('input-right');

        let thumbLeft = document.querySelector('.slider > .thumb.left');
        let thumbRight = document.querySelector('.slider > .thumb.right');
        let range = document.querySelector('.slider > .range');

        thumbLeft.style.left = "0%";
        thumbRight.style.right = "0%"
        range.style.left = "0%";
        range.style.right = "0%";

        inputLeft.value = ${minPrice};
        inputRight.value = ${maxPrice};

        $(".dropdownButton__prices").removeAttr('style');

        let selectedBrands = getSelectedBrands(null);
        let selectedColors = getSelectedColors(null);
        let selectedSizes = getSelectedSizes(null);

        filterData(selectedBrands, selectedColors, selectedSizes, ${minPrice}, ${minPrice});

    });


    function filterData(selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice) {

        $.ajax({
            url: '/filterClothes',
            type: 'GET',
            async: true,
            contentType: 'application/json; charset=UTF-8',
            datatype: "JSON",
            data: {
                selectedBrands: selectedBrands,
                selectedColors: selectedColors,
                selectedSizes: selectedSizes,
                minPrice: minPrice,
                maxPrice: maxPrice
            }
        });
    }

</script>
</body>
</html>
