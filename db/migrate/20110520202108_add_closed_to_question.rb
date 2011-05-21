class AddClosedToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :closed, :integer
  end

  def self.down
    remove_column :questions, :closed
  end
end
