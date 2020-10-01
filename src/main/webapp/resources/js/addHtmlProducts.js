var NUMBER_OF_PRODUCTS_PER_PAGE = 9;
var listOfProducts = [];
var isAdmin

function addHtmlProducts(clothesList, admin,) {

    listOfProducts = clothesList;
    isAdmin = admin;
    NUMBER_OF_PRODUCTS_PER_PAGE = 9;

    let clothesSection = document.querySelector('.clothes');

    clothesSection.innerHTML = '';

    if (clothesList.length != 0) {

        let colors = [];
        let i = 0;

        let number = NUMBER_OF_PRODUCTS_PER_PAGE;
        if (NUMBER_OF_PRODUCTS_PER_PAGE >= clothesList.length) {
            number = clothesList.length;
        }

        clothesSection.innerHTML =
            '<div class="container">' +
            '   <div>' +
            '       <div class="row" id="clothesBlocks"></div>' +
            '   </div>' +
            '<div class="clothes__more"></div>' +
            '</div>';

        addProducts(0, number);

        addAdminBlock();

        addMorePages(number);

    } else {

        clothesSection.innerHTML =
            '<div class="headerClothes">' +
            '   <img src="/resources/img/other/sad_smile.png" alt="sadSmile">' +
            '   <div class="headerClothes__title">На жаль, такого типу продукту не знайдено</div>' +
            '   <div class="headerClothes__descr"></div>' +
            '</div>';

    }


}

function addProducts(start, end) {

    for (let i = start; i < end; i++) {

        let product = listOfProducts[i];

        document.getElementById('clothesBlocks').innerHTML +=
            '<div class="block col-md-4" id="' + product.idProduct + '">' +
            '   <a href="/clothes/' + (product.sex === 'Чоловічий одяг' ? 'man' : 'woman') + '/productItem/' + product.idProduct + '">' +
            '       <div class="clothes__block">' +
            '           <div class="clothes__block__img">' +
            '               <img class="clothes__block__img_main"' +
            '                   src="/resources/' + product.image + '"' +
            '                   alt="' + product.productName + '">' +
            '               <div class="hover"></div>' +
            '           </div>' +
            '           <div class="clothes__block__text">' +
            '               <div class="clothes__block__text_title">' + product.description + '</div>' +
            '               <div class="clothes__block__text_price">' + product.price + ' грн. </div>' +
            '           </div>' +
            '       </div>' +
            '   </a>' +
            '   <button onclick="addToFavorite(' + product.idProduct + ')" class="clothes__block__img__favorite">' +
            '       <img class="clothes__block__img__favorite_img" id="favorite"' +
            '           src="/resources/img/other/favorite.png" alt="favorite">' +
            '   </button>' +
            '</div>';

    }
}

function addAdminBlock() {

    if (isAdmin === true) {

        document.getElementById('clothesBlocks').innerHTML +=
            '<div class="col-md-4" id="adminBlock">' +
            '   <div class="clothes__block" style="border: 0.5px grey solid;">' +
            '       <button name="addButton" class="clothes__block__addButton" id="addButton">' +
            '           <img src="/resources/img/other/add.jpg" alt="add">' +
            '       </button>' +
            '   </div>' +
            '</div>';

    }
}

function addMorePages(number) {

    let clothesMore = document.querySelector('.clothes__more');
    clothesMore.innerHTML =
        '<div class="clothes__more_title">Ви переглянули ' +
        '   <span id="numberOfShownProducts">' + number + '</span> із ' +
        '   <span id="totalProducts">' + listOfProducts.length + '</span>' +
        '</div>';

    if (number < listOfProducts.length) {
        clothesMore.innerHTML += '<button onclick="morePages(' + number + ')" class="clothes__more__downloadMore">Загрузити ще</button>';
    }

}

//more pages section
function morePages(number) {

    let start = number;
    let end = number + NUMBER_OF_PRODUCTS_PER_PAGE;

    addProducts(start, end);

    $("#adminBlock").remove();

    addAdminBlock();
    addMorePages(end);

}

/*        if (colors.some(item => item.color === product.color) === false && product.color !== '') {
            colors.push({
                id: i++,
                color: product.color
            });
        }

        let elements = document.querySelectorAll('.filter');
        let tag = document.createElement('select');
        tag.setAttribute('id', "colors");

        elements[3].parentNode.replaceChild(tag, elements[3]);

        loadData("colors", colors, "color", "Колір");*/