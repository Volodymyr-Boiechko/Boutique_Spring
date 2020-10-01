let inputLeft = document.getElementById('input-left');
let inputRight = document.getElementById('input-right');

let thumbLeft = document.querySelector('.slider > .thumb.left');
let thumbRight = document.querySelector('.slider > .thumb.right');
let range = document.querySelector('.slider > .range');

inputLeft.addEventListener('input', setLeftValue);
inputRight.addEventListener('input', setRightValue);

function getLeftValue() {
    let value = inputLeft;
    value.value = Math.min(parseInt(value.value), parseInt(inputRight.value) - 1);
    return value.value;
}

function getRightValue() {
    let value = inputRight;
    value.value = Math.max(parseInt(value.value), parseInt(inputLeft.value) + 1);
    return value.value;
}

// set min price of left range
function setLeftValue() {
    let _this = inputLeft,
        min = parseInt(_this.min),
        max = parseInt(_this.max);

    _this.value = getLeftValue();

    let percent = ((_this.value - min) / (max - min)) * 100;

    thumbLeft.style.left = percent + "%";
    range.style.left = percent + "%";

    document.getElementById('minPrice').innerHTML = _this.value + " грн";
    document.getElementById('minPriceHeader').innerHTML = _this.value + " грн";

}
setLeftValue();

// set max price of right range
function setRightValue() {
    let _this = inputRight,
        min = parseInt(_this.min),
        max = parseInt(_this.max);

    _this.value = getRightValue();

    let percent = ((_this.value - min) / (max - min)) * 100;

    thumbRight.style.right = (100 - percent) + "%";
    range.style.right = (100 - percent) + "%";

    document.getElementById('maxPrice').innerHTML = _this.value + " грн";
    document.getElementById('maxPriceHeader').innerHTML = _this.value + " грн";


}
setRightValue();

function addStyles(input, thumb) {

    input.addEventListener("mouseover", function () {
        thumb.classList.add("hover");
    });

    input.addEventListener("mouseout", function () {
        thumb.classList.remove("hover");
    });

    input.addEventListener("mousedown", function () {
        thumb.classList.add("active");
    });

    input.addEventListener("mouseup", function () {
        thumb.classList.remove("active");
    });

}
addStyles(inputLeft, thumbLeft);
addStyles(inputRight, thumbRight);