class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  # GET /albums
  # GET /albums.xml
  def index
    @user   = User.find_by_id(params[:user_id])
    @albums = @user.albums.all
    @other_users_albums = user_signed_in? ? Album.find_all_favourited_by_everybody_but(current_user) : []

    respond_to do |format|
      format.html # old_index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  def toggle_favourite
    @user = User.find_by_id(params[:user_id])
    @album = Album.find_by_id(params[:id])

    if @user.albums.find_by_id(@album.id)
      @user.albums.delete(@album)
      @album_saved = false
    else
      @user.albums << @album
      @album_saved = true
    end

    respond_to do |format|
      format.json  { render :json => @album_saved }
    end
  end
end
