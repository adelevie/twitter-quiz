class User < ActiveRecord::Base
  has_many :quizzes

  devise :database_authenticatable, :confirmable, :recoverable,
         :rememberable, :registerable, :trackable, :timeoutable,
         :token_authenticatable, :twitter_oauth

  attr_accessible :email, :password, :password_confirmation

  def twitter_client
    if self.connected_to_twitter?
      Twitter.configure do |config|
        config.consumer_key = Devise::Twitter.consumer_key
        config.consumer_secret = Devise::Twitter.consumer_secret
        config.oauth_token = self.twitter_oauth_token
        config.oauth_token_secret = self.twitter_oauth_secret
      end
    end

    Twitter
  end

  def connected_to_twitter?
    if (self.twitter_oauth_secret && self.twitter_oauth_token)
      true
    else
      false
    end
  end

end
