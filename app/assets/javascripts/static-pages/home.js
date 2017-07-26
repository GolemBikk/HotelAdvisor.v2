/**
 * Created by alexander on 09.07.17.
 */
function set_sliders() {
    $("#rating").slider({});
    $("#price").slider({});
}

function set_default_btn() {

    $("#details-btn").on('click', function(){
        $('#details').toggle();
        change_gliphicon("#details-btn");
    });
}

function change_gliphicon(element) {
    var tag = $(element).find('i');
    if (tag.hasClass('glyphicon-triangle-bottom')){
        tag.removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-top')
    }
    else{
        tag.removeClass('glyphicon-triangle-top').addClass('glyphicon-triangle-bottom')
    }
}