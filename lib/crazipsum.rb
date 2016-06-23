require 'crazipsum/version'

class Crazipsum
  REGISTER = Hash.new { Crazipsum.new([], fillers: false) }

  class << self
    def register(type, path, opts = {})
      fillers        = opts[:fillers]
      opts[:fillers] = parse_dictionnary(local_dictionnary_path(:fillers)) if fillers.nil? || fillers
      words          = parse_dictionnary(path)
      REGISTER[type] = new(words, opts)
    end

    private

    def parse_dictionnary(path_or_array)
      return path_or_array if path_or_array.is_a?(Array)
      file_content = File.read(path_or_array)
      file_content.split("\n")
    end

    def register_from_gem(type)
      register(type, local_dictionnary_path(type))
    end

    def local_dictionnary_path(type)
      File.expand_path("../../data/#{type}.txt", __FILE__)
    end
  end

  def sentence(opts = {})
    quantity         = opts[:word_count] || rand(7..15)
    quantity         = 0 if quantity < 0
    sentence_fillers = opts[:fillers]
    sentence_fillers = fillers if sentence_fillers.nil?
    dict             = dictionnary
    words = (0...quantity).map do
      next dict.sample unless sentence_fillers
      rand(3) == 0 ? dict.sample : sentence_fillers.sample
    end
    return '' if words.empty?
    words[0] = words[0].capitalize
    words    = words.join(' ')
    "#{words}."
  end

  def paragraph(opts = {})
    quantity  = opts[:sentence_count] || rand(4..7)
    paragraph = []
    quantity.times do
      s = sentence(opts)
      paragraph << s unless s.empty?
    end
    paragraph.join(' ')
  end
  alias sentences paragraph

  def paragraphs(opts = {})
    quantity = opts[:paragraph_count] || rand(3..5)
    paragraphs = []
    quantity.times do
      p = paragraph(opts)
      paragraphs << p unless p.empty?
    end
    paragraphs.join(opts[:seperator] || "\n\n")
  end

  private

  attr_reader :dictionnary, :fillers

  def initialize(words, opts = {})
    @fillers     = opts[:fillers]
    @dictionnary = words
  end

  register_from_gem(:phobia)
  register_from_gem(:religion)
  register_from_gem(:fruit)
  register_from_gem(:mineral)
  register_from_gem(:programming_language)
end

def Crazipsum(type)
  Crazipsum::REGISTER[type]
end
