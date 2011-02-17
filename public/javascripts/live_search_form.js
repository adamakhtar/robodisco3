var live_search_form = {
    initialize : function() {
        live_search_form.setEvents();

    },

    setEvents : function() {
        $("#live_search_form input[type=submit]").click(function(){
            var form = $("#live_search_form");
            var url = "/live_search/";
            var formData = form.serialize();
            $.get(url, formData, null);
            return false;
        });



        // on focus remove any text in the field
        $("#live_search_form input[type=text]").focus( function(){
            $(this).val("");
        })



    }
};

$(function() {
    live_search_form.initialize();
});