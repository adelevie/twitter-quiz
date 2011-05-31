class Tweet < Sinatra::Base

  def handle_tweet(status)
    question = Question.where(:twitter_id_str => status['in_reply_to_status_id_str']).first
    if question
      answerer = Answerer.find_or_create_by_username(status['user']['name'])

      SubmittedAnswer.new do |sa|
        sa.body = status['text']
        sa.twitter_id_str = status['id_str']
        sa.quiz_id = question.quiz_id
        sa.question_id = question.id
        sa.answerer_id = answerer.id
      end.save
    end

  end

  get '/twitter_em_server' do

    user = User.find_by_email('adelevie@gmail.com')
    tw = TwitterStream.new({ :consumer_token => APP_CONFIG['twitter']['consumer_key'],
                             :consumer_secret => APP_CONFIG['twitter']['consumer_secret'],
                             :access_token => user.twitter_oauth_token,
                             :access_secret => user.twitter_oauth_secret })

    i = 0
    tw.userstreams do |status|
      next unless status['text']
      break if i > 5
      i += 1
      handle_tweet(status)
    end

  end

end

