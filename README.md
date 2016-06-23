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

fruit_ipsum.sentence
  # => "Minim ut eiusmod gooseberry acai berry mangosteen raspberry quis rhubarb enim fig grape nulla duis."

fruit_ipsum.sentence(word_count: 5)
  # => "Pear watermelon jujube persimmon nostrud."

fruit_ipsum.sentence(word_count: 5, fillers: false)
  # => "Jackfruit mangosteen melon raspberry nectarine."

fruit_ipsum.sentence(fillers: false)
  # => ""Pear watermelon jujube persimmon nostrud."

fruit_ipsum.paragraph(sentence_count: 3)
  # => "Laborum dolore elderberry cherimoya coconut exercitation dolor banana fugiat watermelon passion fruit. Commodo ut id mollit non tangerine berry reprehenderit lingonberry tamarillo cupidatat kumquat quis. Raisin fig berry in sunt eu rhubarb."

fruit_ipsum.paragraphs(word_count: 2, sentence_count: 2, paragraph_count: 2)
  # => "Id ipsum. Rowanberry pear.\n\nOrange dolore. Sunt mangosteen."
```

The available dictionnaries are:
* [`fruit`](data/fruit.txt)
* [`religion`](data/religion.txt)
* [`programming_language`](data/programming_language.txt)
* [`mineral`](data/mineral.txt)
* [`phobia`](data/phobia.txt)

## License

[MIT](LICENSE.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/groyoh/crazipsum.
