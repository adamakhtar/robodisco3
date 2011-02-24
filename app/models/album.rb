class Album < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tracks

  validates_presence_of :title
  validates_presence_of :artist
  validates_presence_of :mb_id
  validates_uniqueness_of :mb_id

  #returns all albums favourited by everybody but
  #passed user.
  def self.find_all_favourited_by_everybody_but(user, limit = 10)
    self.all(:order => "albums.created_at DESC", :include => "users", :limit => limit,
        :conditions => ["users.id != ? OR users.id != ?", nil, user.id] )
  end

  def self.search_mbrainz_for(query)
    q = MusicBrainz::Webservice::Query.new
    results = q.get_releases(MusicBrainz::Webservice::ReleaseFilter.new(:query => "#{query} OR artist:#{query}"))
    results.collect {|a| Album.new(:title => a.entity.title.to_s,
                                          :artist => a.entity.artist.to_s,
                                          :mb_id => a.entity.id.uuid.to_s )

    }
  end



  def self.search_mbrainz_by_mb_id(params)
    q = MusicBrainz::Webservice::Query.new
    result = q.get_release_by_id(params[:mb_id], :tracks => true, :artist => true)
    album = Album.find_or_create_by_mb_id( :title => result.title.to_s,
               :artist => result.artist.to_s,
               :mb_id => result.id.uuid.to_s )

    if album.tracks.empty?
      result.tracks.each do |t|
        album.tracks.create!(:title => t.title, :artist => t.artist.name )
      end
    end

    return album
  end



end
