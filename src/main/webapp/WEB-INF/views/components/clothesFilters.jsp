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

            <li class="filter">
                <button class="dropdownButton">
                    <div class="dropdownButton__text">Сортувати</div>
                </button>
                <div class="dropdown-content hidden">
                    <div class="list list__sort">
                        <c:if test="${sessionScope.typeName.equals('newestClothes') != true}">
                            <div class="list__el__sort">
                                <div class="list__el__sort_text" style="background-color: #0770cf; color: white;">Ми рекомендуємо</div>
                            </div>
                        </c:if>
                        <div class="list__el__sort">
                            <div class="list__el__sort_text"
                                 <c:if test="${sessionScope.typeName.equals('newestClothes') == true}">style="background-color: #0770cf; color: white;" </c:if>>
                                Новинки
                            </div>
                        </div>
                        <div class="list__el__sort">
                            <div class="list__el__sort_text">Сортувати за зростанням</div>
                        </div>
                        <div class="list__el__sort">
                            <div class="list__el__sort_text">Сортувати за спаданням</div>
                        </div>
                    </div>
                </div>
            </li>

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
                        <button class="headerFilterButton">Очистити</button>
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

        // user selected sort by brands in header section
        let filterName = "${sessionScope.filterName}";
        if (filterName !== "") {

            let filterObjects = [
                <c:forEach items="${sessionScope.filterObjects}" var="item">
                "${item}",
                </c:forEach>
            ];

            let selectFilter = $('#' + filterName + '');
            let listElements = $(selectFilter).closest('.filter').find('.dropdown-content').find('.list').find('.list__el');
            let count = 0;
            for (let i = 0; i < filterObjects.length; i++) {

                let object = filterObjects[i];

                for (let i = 0; i < listElements.length; i++) {

                    let value = $(listElements[i]).attr('data-value');

                    if (value === object) {
                        count++;
                        $(listElements[i]).addClass('selected');
                        $(listElements[i]).find('.list__el_text').attr('style', 'background-color: #0770cf; color: white;');
                        $(listElements[i]).closest('.filter').find('.dropdownButton').attr('style', 'border-top: 2px solid #0770cf;');
                    }

                }
            }
            let headerFilter__text = $(listElements).closest('.dropdown-content').find('.headerFilter').find('.headerFilter__text');
            $(headerFilter__text).html(count + ' вибрано');

            let selectedBrands = getSelectedBrands(null);
            let selectedColors = getSelectedColors(null);
            let selectedSizes = getSelectedSizes(null);
            let minPrice = getLeftValue();
            let maxPrice = getRightValue();
            let sortBy = getSortBy();

            if (count === 0 ) {
                selectedBrands = filterObjects;
            }

            filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        }

        let newClothes = ${sessionScope.newest};
        if (newClothes === true) {
            let listElements = $('.list__sort').find('.list__el__sort');

            listElements.find(".list__el__sort_text").removeAttr('style');

            for (let i = 0; i < listElements.length; i++) {

                let sort = $(listElements[i]).find('.list__el__sort_text').text();

                if (sort.includes('Новинки') || sort === 'Новинки') {
                    $(listElements[i]).find('.list__el__sort_text').attr('style', 'background-color: #0770cf; color: white;');
                    $(listElements).closest('.filter').find('.dropdownButton').attr('style', 'border-top: 2px solid #0770cf;');

                    let selectedBrands = getSelectedBrands(null);
                    let selectedColors = getSelectedColors(null);
                    let selectedSizes = getSelectedSizes(null);
                    let minPrice = getLeftValue();
                    let maxPrice = getRightValue();
                    let sortBy = getSortBy();

                    filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);
                }

            }

        }
        let newestClothesPage = "${sessionScope.typeName}";
        if (newestClothesPage === "newestClothes") {
            let selectedBrands = getSelectedBrands(null);
            let selectedColors = getSelectedColors(null);
            let selectedSizes = getSelectedSizes(null);
            let minPrice = getLeftValue();
            let maxPrice = getRightValue();
            let sortBy = getSortBy();

            filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);
        }

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
            let sortBy = getSortBy();

            filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        });

        $(".headerFilter__button").on('click', function (e) {

            let $wrap = $(this).closest('.filter');
            let filter = $wrap.find('select').attr("id");

            let selectedBrands = getSelectedBrands(filter);
            let selectedColors = getSelectedColors(filter);
            let selectedSizes = getSelectedSizes(filter);
            let minPrice = getLeftValue();
            let maxPrice = getRightValue();
            let sortBy = getSortBy();

            filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

        });

    });

    //if user moved slider
    $("#input-left, #input-right").on('input change', function ()   {

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
        let sortBy = getSortBy();

        filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPriceSelected, maxPriceSelected);

    });

    //reset slider values
    $(".headerFilterButton").on('click', function () {
        document.getElementById('minPrice').innerHTML = ${minPrice} +" грн";
        document.getElementById('minPriceHeader').innerHTML = ${minPrice} +" грн";
        document.getElementById('maxPrice').innerHTML = ${maxPrice} +" грн";
        document.getElementById('maxPriceHeader').innerHTML = ${maxPrice} +" грн";

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
        let sortBy = getSortBy();

        filterData(sortBy, selectedBrands, selectedColors, selectedSizes, ${minPrice}, ${maxPrice});

    });

    $(".list__el__sort").on('click', function () {

        let $wrap = $(this).closest('.filter');

        $wrap.find(".dropdown-content")
            .find(".list")
            .find(".list__el__sort_text")
            .removeAttr('style');

        let text = $(this).find('.list__el__sort_text').text();

        $(this)
            .find(".list__el__sort_text")
            .attr('style', 'background-color: #0770cf; color: white;');

        let compareText = 'Ми рекомендуємо';
        <c:if test="${sessionScope.typeName.equals('newestClothes') == true}">
        compareText = 'Новинки';
        </c:if>


        if (text === compareText || text.includes(compareText) === true) {
            $wrap
                .find('.dropdownButton')
                .removeAttr('style');
        } else {
            $wrap.find('.dropdownButton').attr('style', 'border-top: 2px solid #0770cf;');
        }

        let selectedBrands = getSelectedBrands(null);
        let selectedColors = getSelectedColors(null);
        let selectedSizes = getSelectedSizes(null);
        let minPrice = getLeftValue();
        let maxPrice = getRightValue();
        let sortBy = getSortBy();

        filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice);

    });

    function getSortBy() {

        let sortListElementsText = $(".list__el__sort_text");

        for (let i = 0; i < sortListElementsText.length; i++) {

            let listElementText = sortListElementsText[i];
            let attr = $(listElementText).attr('style');

            if (typeof attr !== typeof undefined && attr !== false) {
                return listElementText.textContent;
            }

        }

    }

    function filterData(sortBy, selectedBrands, selectedColors, selectedSizes, minPrice, maxPrice) {

        $.ajax({
            url: '/filterClothes',
            type: 'GET',
            async: true,
            contentType: 'application/json; charset=UTF-8',
            datatype: "JSON",
            data: {
                sortBy: sortBy,
                selectedBrands: selectedBrands,
                selectedColors: selectedColors,
                selectedSizes: selectedSizes,
                minPrice: minPrice,
                maxPrice: maxPrice
            }
        }).done(function (data) {

            addHtmlProducts(data, ${not empty sessionScope.user && sessionScope.admin != false});

        });
    }

</script>
</body>
</html>
