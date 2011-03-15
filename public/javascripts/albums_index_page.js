var AlbumsIndexPage = {
     initialize : function() {

     },

     toggle : function(){
        var $button_form = $(this).parents("form.button_to");
        var albumId     = $(this).attr("id");
        $.post( $button_form.attr('action'), { id : albumId }, null, "script" );
        return false;
     }
};

$(function(){
    FavouriteButtonTo.initialize();
});
