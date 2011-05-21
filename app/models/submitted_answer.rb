class SubmittedAnswer < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :answerer
	belongs_to :quiz

	scope :correct, where(:correct => 1)

	validates_uniqueness_of :twitter_id_str
end
