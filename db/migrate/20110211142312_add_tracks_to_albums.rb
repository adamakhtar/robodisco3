class AddTracksToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :tracks, :string
  end

  def self.down
    remove_column :albums, :tracks
  end
end
