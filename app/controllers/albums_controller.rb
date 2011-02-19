class AlbumsController < ApplicationController
  # GET /albums
  # GET /albums.xml
  def index
    @user   = User.find_by_id(params[:user_id])
    @albums = @user.albums.find_all

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
    else
      @user.albums << @album
    end

    respond_to do |format|
      format.js  { render :layout => false }
    end
  end
end
