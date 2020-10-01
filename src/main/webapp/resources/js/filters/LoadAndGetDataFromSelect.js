//load multi select
function loadData(filter, listOfElements, filterName, buttonName) {

    $('#' + filter + '').loadData({
        List: listOfElements,
        DisplayText: filterName,
        OtherProperties: "id," + filterName,
        PrimaryKey: "id",
        ButtonName: buttonName
    });
}

function getSelectedBrands(emptyValue) {

    if (emptyValue === "brands") {
        return null;
    }
    let selected = [];

    $("#brands").getSelectedValues({
        PrimaryKey: "id",
        DataValue: "brand",  //Display Property name
        ReturnProperties: "brand",
        IsReturnSingleValue: false
    }, function (response) {
        if (response.status && response.obj != null) {
            for (let i = 0; i < response.obj.length; i++) {
                selected.push(response.obj[i].brand);
            }
        }
    });

    return selected;
}

function getSelectedColors(emptyValue) {

    if (emptyValue === "colors") {
        return null;
    }

    let selected = [];

    $("#colors").getSelectedValues({
        PrimaryKey: "id",
        DataValue: "color",  //Display Property name
        ReturnProperties: "color",
        IsReturnSingleValue: false
    }, function (response) {
        if (response.status && response.obj != null) {
            for (let i = 0; i < response.obj.length; i++) {
                selected.push(response.obj[i].color);
            }
        }
    });

    return selected;

}

function getSelectedSizes(emptyValue) {

    if (emptyValue === "sizes") {
        return null;
    }

    let selected = [];

    $("#sizes").getSelectedValues({
        PrimaryKey: "id",
        DataValue: "size",  //Display Property name
        ReturnProperties: "size",
        IsReturnSingleValue: false
    }, function (response) {
        if (response.status && response.obj != null) {
            for (let i = 0; i < response.obj.length; i++) {
                selected.push(response.obj[i].size);
            }
        }
    });

    return selected;

}