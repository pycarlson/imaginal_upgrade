function setPreference(name, value) {
    $.ajax({
        type: "POST",
        url: "/set_preference",
        data: {name: name, value: value}
    });
}

function initCategoryPreferenceModal(element) {

    var name = $(element).attr('id');
    var value = $(element).html();

    console.log(value);

    var alternates =    $('#' + name + "-alternates").html().split(',');

    var html = "";
    for(var i = 0; i < alternates.length; i++) {
        var alternate = $.trim(alternates[i]);

        var selected = "";
        if(alternate == value) {
            selected = ' selected="selected"';
        }
        if(i == 0) {
            html += "<option value=''" + selected + ">" + alternate + "</option>";
        } else {
            html += "<option" + selected + ">" + alternate + "</option>";
        }

    }

    $('#category-preference-form-value').html(html);

    $('#category-preference-form-name').val(name);
    $('#category-preference-form').modal('show');
}

$(document).ready(function() {
    $('.category-preference-form').submit(function() {

        var name = $('#category-preference-form-name').val();
        var value = $('#category-preference-form-value').val();

        setPreference(name, value);

        if(value == '') {
            value =  $('#' + name + '-default').html();
        }

        $('#' + name).html(value);

        $('#category-preference-form').modal('hide');
        return false;
    })
});

