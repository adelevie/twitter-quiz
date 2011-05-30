class Tweet < Sinatra::Base

  get '/twitter_em_server' do

    tw = TwitterStream.new({ :consumer_token => APP_CONFIG['twitter']['consumer_key'],
                             :consumer_secret => APP_CONFIG['twitter']['consumer_secret'],
                             :access_token => APP_CONFIG['twitter']['oauth_token'],
                             :access_secret => APP_CONFIG['twitter']['oauth_secret'] })

    i = 0
    tw.userstreams do |status|
      next unless status['text']
      break if i > 5
      i += 1
      user = status['user']
      puts "#{user['screen_name']}: #{status['text']}"
    end

  end

end

