class SubmittedAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answerer
  belongs_to :quiz
  after_create :push!

  scope :correct, where(:correct => 1)

  validates_uniqueness_of :twitter_id_str

  def self.fake
    submitted_answer = SubmittedAnswer.new do |sa|
      sa.id = 9999999
      sa.body = "body"
    end
    submitted_answer.answerer = Answerer.new(:username => 'username')
  
    submitted_answer
  end

  def correct!
    self.correct = 0
    self.save
    self.question.close!

    scoreboard_entry = ScoreboardEntry.find_or_create_by_quiz_id(self.quiz_id) do |se|
      se.answerer_id = submitted_answer.answerer_id
    end
    scoreboard_entry.deposit(self.question.points)
    scoreboard_entry.save

    self
  end

  Pusher.app_id = APP_CONFIG['pusher']['app_id']
  Pusher.key = APP_CONFIG['pusher']['key']
  Pusher.secret = APP_CONFIG['pusher']['secret']

  def username
    self.answerer.username
  end

  def as_pusher_json
    self.to_json(:methods => :username, :only => [:id, :body, :username])
  end

  def push!
    #Pusher[self.question.channel_name].trigger("#{self.question.channel_name}-create", self.attributes)
    Pusher['foo'].trigger("foo-create", self.as_pusher_json)
  end
end
