require 'test_helper'

class CrazipsumTest < Minitest::Test
  def self.test(type)
    Object.const_set("Crazipsum#{type.capitalize}Test", Class.new(Minitest::Test) do
      class << self
        attr_accessor :type
      end
      self.type = type

      def test_sentence
        sentence = instance.sentence
        dot      = sentence.slice!(-1)
        words    = sentence.split(' ')
        words[0].downcase!

        assert_equal(sentence[0], sentence[0].upcase)
        assert_equal(dot, '.')
        assert_includes((7..15), words.size)
        words.each do |w|
          assert_includes(dictionnary + fillers, w)
        end
      end

      def test_sentence_with_word_count
        sentence = instance.sentence(word_count: 5)
        dot      = sentence.slice!(-1)
        words    = sentence.split(' ')
        words[0].downcase!

        assert_equal(sentence[0], sentence[0].upcase)
        assert_equal(dot, '.')
        assert_equal(5, words.size)
        words.each do |w|
          assert_includes(dictionnary + fillers, w)
        end
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
        dot      = sentence.slice!(-1)
        words    = sentence.split(' ')
        words[0].downcase!

        assert_equal(sentence[0], sentence[0].upcase)
        assert_equal(dot, '.')
        assert_equal(100, words.size)
        words.each do |w|
          assert_includes(dictionnary, w)
        end
      end

      def test_sentence_with_given_fillers
        sentence = instance.sentence(fillers: ['ah'], word_count: 100)
        dot      = sentence.slice!(-1)
        words    = sentence.split(' ')
        words[0].downcase!

        assert_equal(sentence[0], sentence[0].upcase)
        assert_equal(dot, '.')
        assert_equal(100, words.size)
        words.each do |w|
          assert_includes(dictionnary + ['ah'], w)
        end
      end

      def test_paragraph
        paragraph = instance.paragraph
        dot       = paragraph.slice!(-1)
        sentences = paragraph.split('.')

        assert_equal(dot, '.')
        assert_includes((4..7), sentences.size)
        sentences.each do |sentence|
          words = sentence.split(' ')
          words[0].downcase!

          assert_equal(sentence[0], sentence[0].upcase)
          assert_includes((7..15), words.size)
          words.each do |w|
            assert_includes(dictionnary + fillers, w)
          end
        end
      end

      def test_paragraph_with_sentence_count
        paragraph = instance.paragraph(sentence_count: 2)
        dot       = paragraph.slice!(-1)
        sentences = paragraph.split('.')

        assert_equal(dot, '.')
        assert_equal(2, sentences.size)
        sentences.each do |sentence|
          words = sentence.split(' ')
          words[0].downcase!

          assert_equal(sentence[0], sentence[0].upcase)
          assert_includes((7..15), words.size)
          words.each do |w|
            assert_includes(dictionnary + fillers, w)
          end
        end
      end

      def test_paragraph_with_sentence_options
        paragraph = instance.paragraph(sentence_count: 2, word_count: 2, fillers: false)
        dot       = paragraph.slice!(-1)
        sentences = paragraph.split('.')

        assert_equal(dot, '.')
        assert_equal(2, sentences.size)
        sentences.each do |sentence|
          words = sentence.split(' ')
          words[0].downcase!

          assert_equal(sentence[0], sentence[0].upcase)
          assert_equal(2, words.size)
          words.each do |w|
            assert_includes(dictionnary, w)
          end
        end
      end

      def test_paragraphs
        text       = instance.paragraphs
        paragraphs = text.split("\n\n")
        assert_includes((3..15), paragraphs.size)

        paragraphs.each do |paragraph|
          dot       = paragraph.slice!(-1)
          sentences = paragraph.split('.')

          assert_equal(dot, '.')
          assert_includes((4..7), sentences.size)
          sentences.each do |sentence|
            words = sentence.split(' ')
            words[0].downcase!

            assert_equal(sentence[0], sentence[0].upcase)
            assert_includes((7..15), words.size)
            words.each do |w|
              assert_includes(dictionnary + fillers, w)
            end
          end
        end
      end

      def test_paragraph_with_every_options
        text       = instance.paragraphs(paragraph_count: 2, sentence_count: 2, word_count: 2, fillers: false)
        paragraphs = text.split("\n\n")
        assert_equal(2, paragraphs.size)

        paragraphs.each do |paragraph|
          dot       = paragraph.slice!(-1)
          sentences = paragraph.split('.')

          assert_equal(dot, '.')
          assert_equal(2, sentences.size)
          sentences.each do |sentence|
            words = sentence.split(' ')
            words[0].downcase!

            assert_equal(sentence[0], sentence[0].upcase)
            assert_equal(2, words.size)
            words.each do |w|
              assert_includes(dictionnary, w)
            end
          end
        end
      end

                                                          private

      def instance
        Crazipsum(self.class.type)
      end

      def fillers
        File.read(File.expand_path('../../data/fillers.txt', __FILE__)).split("\n")
      end

      def dictionnary
        File.read(File.expand_path("../../data/#{self.class.type}.txt", __FILE__)).split("\n")
      end
    end)
  end

  def test_version_is_set
    refute_nil(Crazipsum::VERSION)
  end

  test(:fruit)
  test(:religion)
  test(:programming_language)
  test(:mineral)
  test(:phobia)
end
