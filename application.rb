require 'sinatra'
require './lib/twitter_lou_translation'

DEFAULT_TWEET = '腹筋、ハム、股関節を鍛えるのでジムに行く。'

get '/' do
  tweet = params['tweet'] || DEFAULT_TWEET
  if tweet
    @orig_tweet = tweet
    lou = TwitterLouTranslation.new(tweet)
    @new_tweet = lou.translate_tweet
  end
  erb :index
end






