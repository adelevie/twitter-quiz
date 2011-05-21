class AddAskedToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :asked, :integer
  end

  def self.down
    remove_column :questions, :asked
  end
end
