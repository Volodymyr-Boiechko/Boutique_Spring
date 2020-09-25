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

        </ul>

    </div>

</section>
<script>

    $(document).ready(function () {

        let brands = [];
        let idBrand = 1;
        <c:forEach items="${brands}" var="brand">
        brands.push({
            id: idBrand++,
            brand: "${brand}"
        });
        </c:forEach>

        $("#brands").loadData({
            List: brands,
            DisplayText: "brand",
            OtherProperties: "id,brand",
            PrimaryKey: "id",
            ButtonName: "Бренди"
        });

        $("#load").click(function () {

            console.clear();

            $("#brands").getSelectedValues({
                PrimaryKey: "id",
                DataValue: "brand",  //Display Property name
                ReturnProperties: "id,brand",
                IsReturnSingleValue: false
            }, function (response) {
                if (response.status && response.obj != null) {
                    let selectedItemList = response.obj;
                    for (let i = 0; selectedItemList.length; i++) {
                        console.log(selectedItemList[i].brand);
                    }
                }
            });

        });

        let colors = [];
        let idColor = 1;
        <c:forEach items="${colors}" var="color" begin="1">
        colors.push({
            id: idColor++,
            color: "${color}"
        });
        </c:forEach>

        $("#colors").loadData({

            List: colors,
            DisplayText: "color",
            OtherProperties: "id,color",
            PrimaryKey: "id",
            ButtonName: "Колір"

        });

        let sizes = [];
        let idSize = 1;
        <c:forEach items="${sizes}" var="size">
        sizes.push({
            id: idSize++,
            size: "${size}"
        })
        </c:forEach>

        $("#sizes").loadData({
            List: sizes,
            DisplayText: "size",
            OtherProperties: "id,size",
            PrimaryKey: "id",
            ButtonName: "Розмір"
        });

        let sort = [{id: 1, name: "Новинки"}, {id: 2, name: "Сортувати за зростанням"},
            {id: 3, name: "Сортувати за спаданням"}];

        $("#sort").loadData({
            List: sort,
            DisplayText: "name",
            OtherProperties: "id,name",
            PrimaryKey: "id",
            ButtonName: "Сортувати"
        });

        setInterval(function (e) {

            console.clear();

            if ($("#brands").isSelected() || $("#colors").isSelected() || $("#sizes").isSelected() || $("#sort").isSelected()) {
                console.log('selected');
            }

        }, 1500);

    });


</script>
</body>
</html>
