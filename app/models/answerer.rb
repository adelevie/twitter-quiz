class Answerer < ActiveRecord::Base
	has_many :submitted_answers, :dependent => :destroy
	has_many :scoreboard_entries
end
