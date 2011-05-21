class AddAccessTokenSecretToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :access_token_secret, :string
  end

  def self.down
    remove_column :users, :access_token_secret
  end
end
