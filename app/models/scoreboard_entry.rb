class ScoreboardEntry < ActiveRecord::Base
  before_create :set_score
  belongs_to :quiz
  belongs_to :answerer
  scope :ranked, order("score DESC")  

  def deposit(n)
    current_score = self.score
    self.score = current_score + n
    self.save
  end

  private

  def set_score
    self.score = 0
  end

end
