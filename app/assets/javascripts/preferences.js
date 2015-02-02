function setPreference(name, value) {
    $.ajax({
        type: "POST",
        url: "/set_preference",
        data: {name: name, value: value}
    });
}

function initCategoryPreferenceModal(element) {

    var name = $(element).data('id');
    var value = $(element).data('value');

    if(!name) {
        name = $(element).parent().parent().attr('id');
        value = $.trim($(element).html());
    }


  //  console.log(name);
   // console.log(value);

    var alternates = $(element).data('alternates').split(',');

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

        if($('#' + name + ' h5').length) {
            if(value == '') {
                value =  $('#' + name + ' h5').data('default');
            }

            $('#' + name + ' h5').html(value);
        }
        if($('#' + name + ' .star a').length) {
            $('#' + name + ' .star a').data('name', value);
        }

        if($('h2#' + name).length) {
            $('h2#' + name).html(value + "<span>" + $('h2#' + name + ' span').html() + "</span>");
            $('h2#' + name).data('value', value);
        }

        $('#category-preference-form').modal('hide');
        return false;
    })
});

