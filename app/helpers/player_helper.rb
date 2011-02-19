module PlayerHelper
  def favourite_link
    if user_signed_in?
      if current_user.albums.find_by_mb_id(@album.mb_id)
        button_to "Remove From Favourites", toggle_favourite_user_album_path(current_user, @album),{ :class => "favourite" }
      else
        button_to "Add To Favourites", toggle_favourite_user_album_path(current_user, @album), { :class => "favourite" }
      end
    else
        button_to "Add To Favourites", "#", :class => "favourite"
    end
  end
end
