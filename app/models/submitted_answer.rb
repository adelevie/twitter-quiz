class SubmittedAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  belongs_to :answerer
  belongs_to :quiz
  after_create :push!

  scope :correct, where(:correct => 1)

  validates_uniqueness_of :twitter_id_str

  Pusher.app_id = '5737'
  Pusher.key = '3ebbf4b67aef09218611'
  Pusher.secret = '8adf397e12b9c8a956eb'

  def push!
    Pusher['things'].trigger(self.question.channel_name+"-create", self.attributes
  end
end
