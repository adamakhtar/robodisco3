module PlayerHelper
  def favourite_link
    if user_signed_in?
      if current_user.albums.find_by_mb_id(@album.mb_id)
        button_to "Unfavourite", toggle_favourite_user_album_path(current_user, @album),{ :class => "favourite_toggle", :id => @album.id }
      else
        button_to "Favourite", toggle_favourite_user_album_path(current_user, @album), { :class => "favourite_toggle", :id => @album.id }
      end
    else
        button_to "Favourite", "#", :class => "login_required"
    end
  end
end
