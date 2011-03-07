module PlayerHelper
  def favourite_link
    if user_signed_in?
      if current_user.albums.find_by_mb_id(@album.mb_id)
        button_to "Liked", toggle_favourite_user_album_path(current_user, @album),{:class => "favourite_toggle liked", :id => @album.id }
      else
        button_to "Like", toggle_favourite_user_album_path(current_user, @album), {:class => "favourite_toggle like", :id => @album.id }
      end
    else
        button_to "Like", "#", :class => "login_required favourite_toggle like"
    end
  end
end
