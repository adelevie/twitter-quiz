class AddQuizIdToSubmittedAnswer < ActiveRecord::Migration
  def self.up
    add_column :submitted_answers, :quiz_id, :integer
  end

  def self.down
    remove_column :submitted_answers, :quiz_id
  end
end
