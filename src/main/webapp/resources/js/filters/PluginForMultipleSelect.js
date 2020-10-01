function makeAttrByProperties(e, t) {
    let i = "";
    if ("" !== $.trim(e.PrimaryKey) && (i += e.PrePrimaryKey + e.PrimaryKey + '="' + t[e.PrimaryKey] + '" '), "" !== $.trim(e.OtherProperties)) {
        let s = e.OtherProperties.split(",");
        $.map(s, function (s) {
            (s = $.trim(s)) === e.ParentKey ? i += s + '="' + t[e.ParentKey] + '" ' : i += s + '="' + t[s] + '" '
        })
    }
    return i
}

$.fn.loadData = function (e) {
    let t = $.extend({
        FirstItem: "None",
        List: "",
        DisplayText: "",
        OtherProperties: "",
        PrePrimaryKey: "",
        PrimaryKey: "id",
        ParentKey: "",
        IsMultiple: !0,
        Placeholder: "Пошук",
        MaxWidth: 275,
        TypeAndSearch: !1,
        MethodName: "",
        ButtonName: ""
    }, e), i = $(this);
    t.IsMultiple && i.attr("multiple", "multiple"), "" === t.List && (t.List = []);
    let s = t.List;
    if ("None" !== t.FirstItem) {
        let e = {[t.PrimaryKey]: 0, [t.DisplayText]: t.FirstItem};
        s.unshift(e)
    }
    if ($.map(s, function (e) {
        let s = null != e ? makeAttrByProperties(t, e) : "";
        i.append("<option " + s + ">" + e[t.DisplayText] + "</option>")
    }), i.multiSelect(t.ButtonName, undefined), i.closest(".filter"), i.closest(".filter")
        .find(".search input[type='text']").attr("placeholder", t.Placeholder),
    0 === i.siblings(".dropdown-content").find(".list .g0").length) {

        let l = 0;
        $.map(s, function (e) {
            i.siblings(".dropdown-content").find(".list").append(
                "<div class='list__el g0' data-value=" + e[t.DisplayText] + " data-index='" + l + "'>" +
                "<div class='list__el_text'>'" + e[t.DisplayText] + "</div>" +
                "</div>"), l++
        })
    }
}, $.fn.getSelectedValues = function (e, t) {
    let i = $.extend({
        PrePrimaryKey: "",
        PrimaryKey: "",
        DataValue: "",
        ReturnProperties: "",
        IsReturnSingleValue: !1
    }, e);
    let s = [], l = $(this), n = [];
    if (i.IsReturnSingleValue) {
        let e = l.siblings(".dropdownButton")
            .find(".dropdownButton__text").text();
        l.siblings(".dropdown-content")
            .find(".list")
            .find(".list__el").removeClass("selected"),
            l.siblings(".dropdown-content")
                .find(".list")
                .find(".list__el[data-value='" + e + "']").addClass("selected")
    }
    l.siblings(".dropdown-content")
        .find(".list")
        .find(".selected").each(function () {

        n.push($(this).attr("data-value"))
    });
    let a = i.ReturnProperties.split(",");
    return l.find("option").each(function () {
        let e = $(this), t = n.find(e => e === $(this).attr(i.DataValue));
        if ("" !== t && void 0 !== t) {
            let t = {};
            $.map(a, function (i) {
                i = $.trim(i), t[i] = e.attr(i)
            }), s.push(t)
        }
        if (i.IsReturnSingleValue && 1 === s.length) return !1
    }), s.length > 0 && "" !== $.trim(i.PrimaryKey) && s.map(e => e[i.PrimaryKey] = e[i.PrePrimaryKey + i.PrimaryKey]), t({
        status: !0,
        obj: i.IsReturnSingleValue ? s[0] : s
    })
};