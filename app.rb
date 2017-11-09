require './lib/twitter_lou_translation'

DEFAULT_TWEET = '腹筋、ハム、股関節を鍛えるのでジムに行く。'

tweet = ARGV[0] || DEFAULT_TWEET

lou = TwitterLouTranslation.new(tweet)
new_tweet = lou.translate_tweet

puts new_tweet