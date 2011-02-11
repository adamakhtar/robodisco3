class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.integer :album_id
      t.string :title
      t.string :artist

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
