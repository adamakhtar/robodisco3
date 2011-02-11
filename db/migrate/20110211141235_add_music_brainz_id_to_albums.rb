class AddMusicBrainzIdToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :mb_id, :string, :limit => 36
  end

  def self.down
    remove_column :albums, :mb_id
  end
end
