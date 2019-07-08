require 'ruby_rhymes'
# require 'engtagger'
# require 'pry'
require 'rest-client'
# require 'dream_cheeky'



### Makes a haiku with lines ending in nouns
# def make
# ### Makes a line ending in a noun
# def make_noun_ended_line(text, len)
#   tgr = EngTagger.new
#   tagged = tgr.add_tags(text)

# end

class Haiku
### Makes a haiku using markov chains built from the provided source text
  def markov_haiku(text)
    text_hash = analyze_text(text)
    line_1 = make_markov_line(text_hash, 5)
    line_2 = make_markov_line(text_hash, 7)
    line_3 = make_markov_line(text_hash, 5)
    [line_1,line_2,line_3]
  end
  ### Builds the markov chain text hash
  def analyze_text(text)
    hash = Hash.new(Array.new)
    text_array = text.split(/\s/)
    text_array.each_with_index do |word, i|
      break if i == (text_array.length - 1)
      hash[word] += [text_array[i + 1]]
    end
    hash
  end
  ### builds one markov chain line, as many sylables long as len
  def make_markov_line(text_hash, len)
    line = text_hash.keys.sample
    word = line
    while true
      if line.to_phrase.syllables == len
        line.gsub!('"','')
        return line
      end
      if line.to_phrase.syllables > len
        line = text_hash.keys.sample
        word = line
      end
      word = text_hash[word].sample
      line = "#{line} #{word}"
    end
  end
  ### Makes a punctuation ended haiku.  Where each line ends in a punctuation mark
  def punctuation_haiku(text)
    line_1 = make_puctuation_ended_line(text, 5)
    line_2 = make_puctuation_ended_line(text, 7)
    line_3 = make_puctuation_ended_line(text, 5)
    [line_1,line_2,line_3]
  end
  ### Makes a single line as long as len, and ending in ! ? . : \ or new line
  def make_puctuation_ended_line(text, len)
    phrases = text.split(/[\!\?\.\:\;\(\)\n]/)
    phrases.shuffle!
    phrases.each do |phrase|
      words = phrase.split(" ")
      words.reverse!
      line = ""
      words.each do |word|
        begin
          line = "#{word} #{line}"
          if line.to_phrase.syllables == len
            line.gsub!('"','')
            return line
          end
          if line.to_phrase.syllables > len
            break
          end
        rescue
          break
        end
      end
    end
  end

  ### Makes a haiku built from random snippits of text
  def haiku(text)
    text_array = text.split(" ")
    line_1 = make_line(text_array, 5)
    line_2 = make_line(text_array, 7)
    line_3 = make_line(text_array, 5)
    [line_1,line_2,line_3]
  end
  ### Makes a line of length len sylables, from random consecutive snippits of text
  def make_line(text_array, len)
    start = rand(text_array.length)
    val = start
    line = ""
    while true
      val = val + 1
      line = "#{line} #{text_array[val]}"
      if line.to_phrase.syllables == len
        line.gsub!('"','')
        return line
      end
      if line.to_phrase.syllables > len
        line = ""
        start = start + 1
        val = start
      end
    end
  end
  ### use osx say to read the haiku
  def say_haiku(line_1, line_2,line_3, voice = "daniel")
    `say -v #{voice} "#{line_1}"`
    puts line_1
    `say -v #{voice} "#{line_2}"`
    puts line_2
    `say -v #{voice} "#{line_3}"`
    puts line_3
  end
  ### Post Haiku to random slack channel
  def post_haiku(line_1,line_2,line_3)
    url = ENV["SLACK_URL"]
    payload = {username: "haiku-bot", icon_url: "christmas-haiku.jpg", text: line_1+"\n"+line_2+"\n"+line_3, channel: "#random"}
    RestClient.post(url, payload.to_json, accept: :json)
  end


  def create(source, type="punctuation")
    contents = File.open(File.expand_path("../..", __FILE__) +"/"+ FILES[source.to_sym], "rb").read
    case type
    when "punctuation"
      punctuation_haiku(contents)
    when "markov"
      markov_haiku(contents)
    else
      haiku(contents)
    end
  end

  FILES = {
    alice: "lib/source/alice.txt",
    shakespere: "lib/source/shakespere.txt",
    home: "lib/source/home.txt",
    german: "lib/source/german.txt",
    beer: "lib/source/beer.txt",
    communism: "lib/source/communism.txt",
    lorax: "lib/source/lorax.txt",
    bible: "lib/source/bible.txt",
    dogs: "lib/source/dogs.txt",
    mensa: "lib/source/mensa.txt",
    linken_park:"lib/source/linken.txt",
    tswift: "lib/source/tswift.txt",
    dickens: "lib/source/dickens.txt",
    christmas: "lib/source/chistmas.txt",
  }

end
