class CreateAlbumsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :albums_users do |t|
      t.integer :user_id
      t.integer :album_id
      t.timestamps
    end
  end

  def self.down
    drop_table :albums_users
  end
end
