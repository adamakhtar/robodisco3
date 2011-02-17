class PlayerController < ApplicationController
  def show
    @album = Album.find_by_mb_id(:mb_id => params[:mb_id])
    @tracks = @album.tracks
    @other_youtube_videos = nil
  end

  def retrieve_videos
    @other_youtube_videos = Track.query_youtube_for_videos(:query => params[:track_info], :page => params[:page])
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end



end
