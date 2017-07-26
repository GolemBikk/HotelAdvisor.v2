/**
 * Created by alexander on 26.07.17.
 */
function check_reviews_length() {
    $(".full-text-btn").click(function() {
        var review = $(this).parent().parent();
        toggle_full_text(review);
        change_btn_content(this);
    });
}

function toggle_full_text(review) {
    $(review).find(".text-preview").toggle();
    $(review).find(".text-full").toggle();
}

function change_btn_content(element) {
    change_gliphicon(element);
    if($(element).text().indexOf("Свернуть") >= 0) {
        change_text(element, "Свернуть", "Показать больше");
    }
    else if($(element).text().indexOf("Показать больше") >= 0) {
        change_text(element, "Показать больше", "Свернуть");
    }
}

function change_text(element, old_text, new_text) {
    var content = $(element).html();
    content = content.replace(old_text, new_text);
    $(element).html(content);
}