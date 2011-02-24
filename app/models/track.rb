class Track < ActiveRecord::Base
  has_and_belongs_to_many :albums

  before_save :remove_bracketed_text

  def remove_bracketed_text()
    self.title  = title.gsub(/\(.*?\)/,"").strip
    self.artist = artist.gsub(/\(.*?\)/,"").strip
  end


  def self.query_youtube_for_videos(options)
    options.reverse_merge!(:query => "", :page => 1, :per_page => 7)
    client = YouTubeIt::Client.new
    videos = client.videos_by(options).videos
    videos.map do |video|
          {:title => video.title,
           :thumbnail_url => video.thumbnails.first.url,
           :player_url => video.player_url,
           :embed_url => video.embed_url,
           :view_count => video.view_count,
           :unique_id => video.unique_id  }
    end
  end
end
