module PlayerHelper
  def favourite_link
    if user_signed_in? && current_user.albums.find_by_mb_id(@album.mb_id)
      link_to "Remove From Favourites", "#"
    else
      link_to "Add To Favourites", "#"
    end
  end
end
