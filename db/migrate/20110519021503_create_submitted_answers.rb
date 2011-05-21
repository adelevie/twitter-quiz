class CreateSubmittedAnswers < ActiveRecord::Migration
  def self.up
    create_table :submitted_answers do |t|
      t.string :body
      t.integer :question_id
      t.integer :answerer_id
      t.integer :correct

      t.timestamps
    end
  end

  def self.down
    drop_table :submitted_answers
  end
end
