class AddTwitterIdStrToSubmittedAnswer < ActiveRecord::Migration
  def self.up
    add_column :submitted_answers, :twitter_id_str, :string
  end

  def self.down
    remove_column :submitted_answers, :twitter_id_str
  end
end
