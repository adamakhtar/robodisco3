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

end
