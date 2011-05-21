class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :submitted_answers, :dependent => :destroy
  has_many :answerers, :through => :submitted_answers
  has_one :user, :through => :quiz

  scope :asked, where(:asked => 1)

  def correct_submitted_answer
	  self.submitted_answers.select {|a| a.correct == 1}.first
  end

  def next_question
	  Question.where("created_at > :created_at", {:created_at => self.created_at}).order(" created_at ASC").where(:quiz_id => self.quiz_id).first
  end

  def is_last?
	  self.next_question.nil?
  end

  def asked?
	  if self.asked != 1
		  false
	  elsif self.asked == 1
		  true
	  end
  end

  def ask
	  unless self.asked?
		  res = self.user.twitter_client.update("#{self.body} (#{self.points} pts)")
		  self.twitter_id_str = res.id_str
		  self.asked = 1
		  self.save
	  end

	  self
  end

  def save_submitted_answers
	  twitter_submitted_answers.each do |tweet|
		  answerer = Answerer.find_or_create_by_username(tweet.user.name)

		  SubmittedAnswer.new do |sa|
			  sa.body = tweet.text
			  sa.twitter_id_str = tweet.id_str
			  sa.quiz_id = self.quiz_id
			  sa.question_id = self.id
			  sa.answerer_id = answerer.id
		  end.save
	  end
	
	  self.submitted_answers
  end

  def twitter_submitted_answers
	  self.user.twitter_client.mentions.delete_if do |t| 
		  t.in_reply_to_status_id_str != self.twitter_id_str
	  end
  end

end
