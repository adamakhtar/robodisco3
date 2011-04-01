class SearchController < ApplicationController
  before_filter :authenticate_user!, :only => [:results]

  def new
  end

  def results
    if params[:query].blank?
      redirect_to :action => :new
    else
      @albums =  Album.search_mbrainz_for(params[:query]).group_by(&:artist)
    end
  end


end
