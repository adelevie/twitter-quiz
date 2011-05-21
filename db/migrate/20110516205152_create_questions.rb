class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :body
      t.integer :points
      t.integer :quiz_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
