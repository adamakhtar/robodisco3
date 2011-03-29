class AddInvitedByIdAndInvitedByTypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invited_by_id, :integer
    add_column :users, :invited_by_type, :string
  end

  def self.down
    remove_column :users, :invited_by_id
    remove_column :users, :invited_by_type
  end
end
