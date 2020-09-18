function addToFavorite(idProduct) {

    let success = false;

    $.ajax({

        url: "/favoriteProducts/" + idProduct,
        async: false,
        method: "POST",

    }).done(function (response) {

        console.log(response.status)
        success = true;
        let item = document.getElementById(idProduct);

        let img = item.querySelector('#favorite');

        if (response === "add") {

            alert("Продукт додано до улюблених");
            img.src = window.location.origin + "/resources/img/other/favoriteFull.png";
        } else if (response === "remove") {

            alert("Продукт видалено з улюблених");
            img.src = "/resources/img/other/favorite.png";

            let index = array.indexOf(idProduct);
            if (index > -1) {
                array.splice(index, idProduct);
            }

        }

    }).fail(function (response) {

        success = false;
        console.log(response.status);

        if (response.status === 401) {
            alert("Потрібно увійти");
        } else if (response.status === 500) {
            alert("Проблеми з сервером");
        }

    });

    return success;

}