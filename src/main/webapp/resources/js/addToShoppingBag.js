function addToShoppingBag(idProduct) {

    let success = false;

    $.ajax({

        url: '/shoppingBag/' + idProduct,
        async: false,
        type: 'POST',

    }).done(function (response) {

        alert('Продукт додано в корзину');
        console.log(response.status);

        success = true;
        location.reload();

    }).fail(function (response) {

        success = false;
        console.log(response.status);

        if (response.status === 401) {
            alert('Потрібно увійти!');
        }
        else if (response.status === 403) {
            alert('Продукт вже доданий в корзину!');
        }
        else if (response.status === 500) {
            alert('Виникла помилка на сервері');
        }


    });

    return success;

}