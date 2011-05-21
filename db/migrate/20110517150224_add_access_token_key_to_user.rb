class AddAccessTokenKeyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :access_token_key, :string
  end

  def self.down
    remove_column :users, :access_token_key
  end
end
