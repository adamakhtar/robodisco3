class PlayerController < ApplicationController
  def show
    @album = Album.find_by_mb_id(:mb_id => params[:mb_id])
    @tracks = @album.tracks
    @other_youtube_videos = nil
  end

  def retrieve_videos

    @other_youtube_videos = fetch_videos_from_youtube(:query => params[:track_info], :page => params[:page])
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end

  private

  def fetch_videos_from_youtube(params)
    raise ArgumentError, "must supply a query to search for" unless params[:query] &&
            !params[:query].blank?
    client = YouTubeG::Client.new
    client.videos_by(:query => params[:query],
                     :page => params[:page] || 1,
                     :per_page => 7).videos.map do |video|
      {:title => video.title, :thumbnail_url => video.thumbnails.first.url, :player_url => video.player_url,
                :embed_url => video.embed_url, :view_count => video.view_count, :unique_id => video.unique_id }

    end
  end

end
