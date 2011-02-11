class CreateAlbumsTracksJoinTable < ActiveRecord::Migration
  def self.up
    create_table :albums_tracks, :id => false do |t|
      t.integer :album_id
      t.integer :track_id
      t.timestamps
    end
  end

  def self.down
    drop_table :albums_tracks
  end
end
