class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :update, :destroy, :read, :to => :modify

    can :create, Quiz

    can :modify, Quiz do |quiz| 
      quiz.try(:user_id) == user.id
    end

    can :create, Question do |question|
      question.quiz.try(:user_id) == user.id
    end

    can :modify, Question do |question|
      question.quiz.try(:user_id) == user.id
    end

    can :modify, SubmittedAnswer do |submitted_answer|
      submitted_answer.quiz.try(:user_id) == user.id
    end

  end
end
