class AlbumsController < ApplicationController
  before_filter :authenticate_user!, :only => [:toggle_favourite]
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
    else
      @user.albums << @album
    end

    respond_to do |format|
      format.js  { render :layout => false }
    end
  end
end
