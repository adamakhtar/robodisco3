var search_form = {
    initialize : function(){
    $("#search_form input[type=text]").focus( function(){
        $(this).val("");
    })
    }
};


$(function() {
    search_form.initialize();
});