function deleteAddress(idAddress) {

    let success = false;

    $.ajax({

        url: '/userProfile/userAddresses/' + idAddress,
        async: false,
        type: "DELETE"

    }).done(function (response) {

        console.log(response.status);

        success = true;
        alert('Адресу видалено');
        window.location.href = "/userProfile/userAddresses";

    }).fail(function (response) {

        success = false;

        if (response.status === 500) {
            alert("Виникла помилка на сервері");
        }

    });

    return success;

}