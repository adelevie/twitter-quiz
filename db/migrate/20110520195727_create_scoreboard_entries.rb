class CreateScoreboardEntries < ActiveRecord::Migration
  def self.up
    create_table :scoreboard_entries do |t|
      t.integer :quiz_id
      t.integer :answerer_id
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :scoreboard_entries
  end
end
