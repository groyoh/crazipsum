# frozen_string_literal: true

module Crazipsum
  # Generator generates lorem ipsum sentences, paragraphs and text based on a
  # Dictionnary.
  class Generator
    DEFAULT_WORD_COUNT_RANGE = (7..15).freeze
    DEFAULT_SENTENCE_COUNT_RANGE = (4..7).freeze
    DEFAULT_PARAGRAPH_COUNT_RANGE = (3..5).freeze
    DEFAULT_PARAGRAPH_SEPARATOR = "\n\n"

    # Returns a new instance of Generator that will used words and fillers from
    # the given Dictionnary to generate the lorem ipsum texts.
    def initialize(dictionnary)
      @dictionnary = dictionnary
    end

    # Generates a lorem ipsum sentence based on the generator's dictionnary.
    #
    # @param [integer] word_count the number of words expected in the sentence.
    # @param [Array<String>] fillers a list of words used to fill in the lorem ipsum.
    # @return [String] a lorem ipsum sentence.
    def sentence(word_count: rand(DEFAULT_WORD_COUNT_RANGE), fillers: dictionnary.fillers)
      word_count = 0 if word_count.negative?
      dictionnary_words = dictionnary.words
      words = (0...word_count).map do
        next dictionnary_words.sample if fillers.nil? || fillers == false || fillers.empty?

        rand(3).zero? ? dictionnary_words.sample : fillers.sample
      end
      return '' if words.empty?

      words[0] = words[0].capitalize
      words = words.join(' ')
      "#{words}."
    end

    # Generates a lorem ipsum paragraph based on the generator's dictionnary.
    #
    # @param [integer] sentence_count the number of sentences expected in the paragraph.
    # @param [integer] word_count the number of words expected in each sentence.
    # @param [Array<String>] fillers a list of words used to fill in the lorem ipsum.
    # @return [String] a lorem ipsum paragraph.
    def paragraph(
      word_count: rand(DEFAULT_WORD_COUNT_RANGE),
      sentence_count: rand(DEFAULT_SENTENCE_COUNT_RANGE),
      fillers: dictionnary.fillers
    )
      sentence_count = 0 if sentence_count.negative?
      paragraph = []
      sentence_count.times do
        s = sentence(word_count: word_count, fillers: fillers)
        paragraph << s unless s.empty?
      end
      paragraph.join(' ')
    end
    alias sentences paragraph

    # Generates a lorem ipsum text with multiples paragraphs based on the
    # generator's dictionnary.
    #
    # @param [integer] sentence_count the number of sentences expected in the paragraph.
    # @param [integer] sentence_count the number of sentences expected in the paragraphs.
    # @param [integer] word_count the number of words expected in each sentence.
    # @param [Array<String>] fillers a list of words used to fill in the lorem ipsum.
    # @return [String] a lorem ipsum text.
    def paragraphs(
      word_count: rand(DEFAULT_WORD_COUNT_RANGE),
      sentence_count: rand(DEFAULT_SENTENCE_COUNT_RANGE),
      paragraph_count: rand(DEFAULT_PARAGRAPH_COUNT_RANGE),
      fillers: dictionnary.fillers,
      seperator: DEFAULT_PARAGRAPH_SEPARATOR
    )
      paragraph_count = 0 if paragraph_count.negative?
      paragraphs = []
      paragraph_count.times do
        p = paragraph(word_count: word_count, sentence_count: sentence_count, fillers: fillers)
        paragraphs << p unless p.empty?
      end
      paragraphs.join(seperator)
    end
    alias text paragraphs

    private

    attr_reader :dictionnary
  end
end
