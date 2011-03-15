var PlayerLikeButton = {
     initialize : function() {
        $('input.favourite_toggle').click( PlayerLikeButton.toggle );
     },

     toggle : function(){
        var $button_form = $(this).parents("form.button_to");
        var albumId     = $(this).attr("id");
        var $this = $(this);
        //$.post( $button_form.attr('action'), { id : albumId }, null, "script" );
        $.post( $button_form.attr('action'), { id : albumId }, function(data){
            PlayerLikeButton.update(data, $this);
        });
        return false;
     },

     //callback for toggle request.
     //determines if album was liked or unliked and updates button
     //If liked moves the album to users liked list
     update : function(albumSaved, $button){
         if (albumSaved == true){
             $button.attr("value", "Unlike").toggleClass("like").toggleClass("liked");
         } else {
             $button.attr("value", "Like").toggleClass("like").toggleClass("liked");
         }
     }
};



$(function(){
    PlayerLikeButton.initialize();
});
