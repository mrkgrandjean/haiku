Gem::Specification.new do |s|
  s.name        = 'haiku'
  s.version     = '0.0.2'
  s.date        = '2016-03-30'
  s.summary     = "Haiku Generator"
  s.description = "A gem to generate haikus"
  s.authors     = ["Mark Grandjean"]
  s.email       = 'mark@grandjean.net'
  s.files       = ["lib/haiku.rb",
                   "lib/source/alice.txt",
                   "lib/source/beer.txt",
                   "lib/source/bible.txt",
                   "lib/source/chistmas.txt",
                   "lib/source/communism.txt",
                   "lib/source/dickens.txt",
                   "lib/source/dogs.txt",
                   "lib/source/german.txt",
                   "lib/source/home.txt",
                   "lib/source/linken.txt",
                   "lib/source/lorax.txt",
                   "lib/source/rules.txt",
                   "lib/source/shakespere.txt",
                   "lib/source/tswift.txt",
                   "lib/haiku-kanji.jpg",
                  ]
  # s.homepage    =
    # 'http://rubygems.org/gems/hola'
  s.license       = 'MIT'
  s.add_runtime_dependency 'ruby_rhymes', '~> 0.1.2'
  s.add_runtime_dependency 'rest-client', '~> 1.8.0'
  s.bindir = 'bin'
end
