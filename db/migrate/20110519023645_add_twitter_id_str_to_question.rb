class AddTwitterIdStrToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :twitter_id_str, :string
  end

  def self.down
    remove_column :questions, :twitter_id_str
  end
end
