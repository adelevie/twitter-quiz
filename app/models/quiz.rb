class Quiz < ActiveRecord::Base
	has_many :questions, :dependent => :destroy
	accepts_nested_attributes_for :questions
	has_many :submitted_answers
	belongs_to :user
	has_many :answerers, :source => :submitted_answers
	has_many :scoreboard_entries

	def save_submitted_answers
		self.questions.select {|q| q.asked?}.each do |question|
			question.save_submitted_answers
			sleep(5)
		end 
	end

	def end
		self.user.twitter_client.update("#{self.first_place.user_name} is the winner!")
	end

	def first_place
		self.scoreboard_entries.ranked.first.answerer
	end
	
end
