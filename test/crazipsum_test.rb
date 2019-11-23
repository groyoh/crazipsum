# frozen_string_literal: true

require 'test_helper'

class CrazipsumTest < Minitest::Test
  def self.test(type)
    Object.const_set("Crazipsum#{type.capitalize}Test", Class.new(Minitest::Test) do
      class << self
        attr_accessor :type
      end
      self.type = type

      def test_sentence
        assert_sentence_is_correct(instance.sentence, words + fillers, (7..15))
      end

      def test_sentence_with_word_count
        sentence = instance.sentence(word_count: 5)

        assert_sentence_is_correct(sentence, words + fillers, 5)
      end

      def test_sentence_with_word_count_0
        sentence = instance.sentence(word_count: 0)
        assert_equal(sentence, '')
      end

      def test_sentence_with_word_count_negative
        sentence = instance.sentence(word_count: -5)
        assert_equal(sentence, '')
      end

      def test_sentence_without_fillers
        sentence = instance.sentence(fillers: false, word_count: 100)

        assert_sentence_is_correct(sentence, words, 100)
      end

      def test_sentence_with_given_fillers
        sentence = instance.sentence(fillers: ['ah'], word_count: 100)

        assert_sentence_is_correct(sentence, words + ['ah'], 100)
      end

      def test_paragraph
        assert_paragraph_is_correct(instance.paragraph, words + fillers, sentence_count: (4..7), word_count: (7..15))
      end

      def test_paragraph_with_sentence_count
        paragraph = instance.paragraph(sentence_count: 2)
        assert_paragraph_is_correct(paragraph, words + fillers, sentence_count: 2, word_count: (7..15))
      end

      def test_paragraph_with_sentence_options
        paragraph = instance.paragraph(sentence_count: 2, word_count: 2, fillers: false)
        assert_paragraph_is_correct(paragraph, words, sentence_count: 2, word_count: 2)
      end

      def test_paragraphs
        text       = instance.paragraphs
        paragraphs = text.split("\n\n")
        assert_includes((3..15), paragraphs.length)

        paragraphs.each do |_paragraph|
          assert_paragraph_is_correct(instance.paragraph, words + fillers, sentence_count: (4..7), word_count: (7..15))
        end
      end

      def test_paragraphs_with_every_options
        text       = instance.paragraphs(paragraph_count: 2, sentence_count: 2, word_count: 2, fillers: false)
        paragraphs = text.split("\n\n")
        assert_equal(2, paragraphs.length)

        paragraphs.each do |paragraph|
          assert_paragraph_is_correct(paragraph, words, sentence_count: 2, word_count: 2)
        end
      end

      private

      def instance
        @instance ||= Crazipsum(self.class.type)
      end

      def dictionnary
        @dictionnary ||= Crazipsum::Registry.instance[self.class.type]
      end

      def fillers
        @fillers ||= dictionnary.fillers || []
      end

      def words
        @words ||= dictionnary.words
      end

      def assert_paragraph_is_correct(paragraph, dictionnary_words, sentence_count:, word_count:)
        dot = paragraph[-1]
        assert_equal(dot, '.')

        sentences = paragraph.split('. ')
        (0...sentences.length - 1).each { |idx| sentences[idx] = "#{sentences[idx]}." }
        if sentence_count.is_a?(Range)
          assert_includes(sentence_count, sentences.length)
        else
          assert_equal(sentence_count, sentences.length)
        end

        sentences.each do |sentence|
          assert_sentence_is_correct(sentence, dictionnary_words, word_count)
        end
      end

      # This function will assert that all the words in the sentence are part of
      # the given words.
      # To do so, it will remove all matching words from the sentence and which
      # is not the first or last word in the sentence. Then it will try to
      # remove each word in the sentence except the last one. It will finally
      # try to remove the last one.
      def assert_sentence_is_correct(sentence, dictionnary_words, word_count)
        # We sort the dictionnary_words by length in reverse order so that we go over
        # most specific words first. This avoids removing words that are parts
        # of other words such as "Congo" and "Democratic Republic of Congo"
        dictionnary_words = dictionnary_words.sort_by { |w| -w.length }

        dot = sentence[-1]
        assert_equal(dot, '.')

        words = []
        dictionnary_words.each do |word|
          [
            [proc { |w| /^#{Regexp.escape(w)} /i }, ''],
            [proc { |w| /(?:^| )#{Regexp.escape(w)}\.?$/i }, ''],
            [proc { |w| / #{Regexp.escape(w)} / }, ' ']
          ].each do |transform, replace|
            match = transform.call(word)
            loop do
              new_sentence = sentence.sub(match, replace)
              break if new_sentence.length == sentence.length

              words << word
              sentence = new_sentence
            end
          end
        end
        assert_equal('', sentence)
        if word_count.is_a?(Range)
          assert_includes(word_count, words.length)
        else
          assert_equal(word_count, words.length)
        end
      end
    end)
  end

  def test_version_is_set
    refute_nil(Crazipsum::VERSION)
  end

  Dir['data/*'].each do |file|
    type = File.basename(file, '.txt')
    next if type == 'fillers'

    test(type)
  end

  Crazipsum.register('no_fillers', %w[no filler at all], fillers: false)
  test('no_fillers')

  Crazipsum.register('with_default_fillers', %w[with default fillers])
  test('with_default_fillers')

  Crazipsum.register('with_custom_fillers', %w[with custom fillers], fillers: %w[two fillers])
  test('with_custom_fillers')
end
