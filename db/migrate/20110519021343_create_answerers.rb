class CreateAnswerers < ActiveRecord::Migration
  def self.up
    create_table :answerers do |t|
      t.string :username

      t.timestamps
    end
  end

  def self.down
    drop_table :answerers
  end
end
