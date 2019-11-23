# Crazipsum
![travis](https://travis-ci.org/groyoh/crazipsum.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/groyoh/crazipsum/badge.svg?branch=master)](https://coveralls.io/github/groyoh/crazipsum?branch=master) [![Gem Version](https://badge.fury.io/rb/crazipsum.svg)](https://badge.fury.io/rb/crazipsum)

Ever wanted some dumber, crazier (fancier?) lorem ipsum? Here you go!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crazipsum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crazipsum

## Usage

```ruby
require 'crazipsum'

fruit_ipsum = Crazipsum(:fruit)

fruit_ipsum.sentence # => "Tangerine berry ut incididunt java-plum enim labore."

fruit_ipsum.sentence(word_count: 5) # => "Pummelo sed coconut veniam occaecat."

fruit_ipsum.sentence(word_count: 5, fillers: false) # => "Raspberry youngberry jujube tangerine pomegranate."

fruit_ipsum.sentence(word_count: 5, fillers: ["yum", "yum"]) # => "Yum mangosteen yum melon acaiberry."

fruit_ipsum.paragraph(sentence_count: 3, word_count: 2, fillers: false) # => "Grape lime. Elderberry tayberry. Date starfruit."

fruit_ipsum.paragraphs(word_count: 2, sentence_count: 2, paragraph_count: 2) # => "Apple starfruit. Dewberry cherimoya.\n\nTangelo apple. Persimmon tamarillo."

# Register a custom lorem ipsum.
Crazipsum.register(
  :superhero,
  ["Batman", "Superman", "Iron Man"]
)

Crazipsum(:superhero).sentence(word_count: 5) # => "Eiusmod laboris Iron Man Batman in."
```

The available dictionnaries are:
* [`car_make`](data/car_make.txt)
* [`phobia`](data/phobia.txt)
* [`programming_language`](data/programming_language.txt)
* [`animal`](data/animal.txt)
* [`fruit`](data/fruit.txt)
* [`constellation`](data/constellation.txt)
* [`mineral`](data/mineral.txt)
* [`religion`](data/religion.txt)
* [`country`](data/country.txt)

## License

[MIT](LICENSE.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groyoh/crazipsum.
