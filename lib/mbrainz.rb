module MBrainz
  def find_all(query)
    q = MusicBrainz::Webservice::Query.new
    results = q.get_releases(MusicBrainz::Webservice::ReleaseFilter.new(:query => "#{query} OR artist:#{query}"))
    results.collect {|a| Album.new(:title => a.entity.title.to_s,
                                          :artist => a.entity.artist.to_s,
                                          :mb_id => a.entity.id.uuid.to_s )

    }
  end

  def find_by_mb_id(params)
    q = MusicBrainz::Webservice::Query.new
    result = q.get_release_by_id(params[:mb_id], :tracks => true, :artist => true)
    album = Album.new( :title => result.entity.title.to_s,
               :artist => result.entity.artist.to_s,
               :mb_id => result.entity.id.uuid.to_s )

    result.tracks.each do |t|
      album.tracks.create(:title => t.title, :artist => t.artist )
    end
  end

end