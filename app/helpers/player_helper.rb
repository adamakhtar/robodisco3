module PlayerHelper
  def favourite_link
    if user_signed_in? && current_user.albums.find_by_mb_id(@album.mb_id)
      link_to "Remove From Favourites", "#", :class => "favourite"
    else
      link_to "Add To Favourites", "#", :class => "favourite"
    end
  end
end
