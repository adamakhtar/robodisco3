class RemoveTracksFromAlbum < ActiveRecord::Migration
  def self.up
    remove_column :albums, :tracks
  end

  def self.down
    add_column :albums, :tracks, :string
  end
end
