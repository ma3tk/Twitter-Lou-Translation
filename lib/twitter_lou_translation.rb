require 'natto'
require 'glosbe'

class TwitterLouTranslation
  attr_accessor :tweet, :mecab

  def initialize(tweet)
    self.tweet = tweet
    self.mecab = Natto::MeCab.new("%m,\\s%f[0],\\s%s")
  end

  def translate_tweet
    new_tweet = ''

    create_morpheme_list.each do |n|
      if n.feature == '名詞'

        translated = translate(n.surface)
        if translated
          # 翻訳後の方が短い、ルー語にすべきケース
          if n.surface.size.to_f > translated.size.to_f/2
            new_tweet += translated
          else
            new_tweet += n.surface
          end
        else
          new_tweet += n.surface
        end

      else
        new_tweet += n.surface
      end
    end

    new_tweet
  end

  def create_morpheme_list
    ret = []

    mecab.enum_parse(tweet).each do |morph|
      ret << Morpheme.new(morph.surface, morph.feature.split(',')[0])
    end

    ret
  end

  def translate(word)
    translator = Glosbe::Translate.new('jpn', 'eng')
    translator.translate(word)
  end
end

class Morpheme
  attr_accessor :surface, :feature

  def initialize(surface, feature)
    self.surface = surface
    self.feature = feature
  end

end