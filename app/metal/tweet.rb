class Tweet < Sinatra::Base

  get '/twitter_em_server' do

    user = ""
    password = ""

    #url = 'http://stream.twitter.com/1/statuses/sample.json'
    url = 'http://stream.twitter.com/1/statuses/mentions.json'

    def handle_tweet(tweet)
      return unless tweet['text']
      puts "#{tweet['user']['screen_name']}: #{tweet['text']}"


      answerer = Answerer.find_or_create_by_username(tweet['user']['screen_name'])

      SubmittedAnswer.new do |sa|
        sa.body = tweet['text']
        sa.twitter_id_str = tweet['id_str']
        sa.quiz_id = 99999
        sa.question_id = 1234
        sa.answerer_id = answerer.id
      end.save

    end

    EventMachine.run do
      http = EventMachine::HttpRequest.new(url).get :head => { 'Authorization' => [ user, password ] }

      buffer = ""

      http.stream do |chunk|
        buffer += chunk
        while line = buffer.slice!(/.+\r?\n/)
          handle_tweet JSON.parse(line)
        end
      end
    end
  end

end

