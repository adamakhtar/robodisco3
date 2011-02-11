module MBrainz
  def find_all(query)
      q = MusicBrainz::Webservice::Query.new
      results = q.get_releases(MusicBrainz::Webservice::ReleaseFilter.new(:query => "#{query} OR artist:#{query}"))
      return results.collect {|a| Album.new(:title => a.entity.title.to_s,
                                            :artist_name => a.entity.artist.to_s,
                                            :mb_id => a.entity.id.uuid.to_s) }
    end

    def find_by_mb_id(params)
      q = MusicBrainz::Webservice::Query.new
      result = q.get_release_by_id(params[:mb_id], :tracks => true, :artist => true)
      Album.new( :release_result => result ) #include tracks as well
    end

end