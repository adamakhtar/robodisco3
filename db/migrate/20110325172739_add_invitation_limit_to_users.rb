class AddInvitationLimitToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invitation_limit, :integer
  end

  def self.down
    remove_column :users, :invitation_limit
  end
end
