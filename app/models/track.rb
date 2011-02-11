class Track < ActiveRecord::Base
  has_and_belongs_to_many :albums

  before_save :remove_bracketed_text

  def remove_bracketed_text()
    self.title = title.gsub(/\(.*?\)/,"")
  end
end
