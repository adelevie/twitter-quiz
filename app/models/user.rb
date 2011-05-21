class User < ActiveRecord::Base
  has_many :quizzes

  after_initialize :setup_twitter  
  devise :database_authenticatable, :confirmable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable,
         :token_authenticatable, :twitter_oauth

  attr_accessible :email, :password, :password_confirmation

  def twitter_client
    Twitter
  end

  def connected_to_twitter?
    if (self.twitter_oauth_token && self.twitter_oauth_secret)
      true
    else
      false
    end
  end

end
