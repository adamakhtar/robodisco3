class RemoveUserIdFromAlbumTable < ActiveRecord::Migration
  def self.up
    self.remove_column :albums, :user_id
  end

  def self.down
    self.add_column :albums, :user_id, :integer
  end
end
