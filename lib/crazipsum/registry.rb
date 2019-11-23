# frozen_string_literal: true

require 'singleton'

require 'crazipsum/dictionnary'
require 'crazipsum/generator'

module Crazipsum
  # Registry is a singleton class that registers and stores different
  # dictionnary types.
  class Registry
    include Singleton

    def initialize
      @registry = {}
    end

    # Registers a new type of Dictionnary that can later be retrieved with #[].
    #
    # @param [String,Symbol] type a name for that dictionnary. This type will be
    #                        used later when calling `Crazipsum(type)`.
    # @param [Array<String>] words a list of words used when generating the lorem ipsum.
    # @param [Array<String>, false] fillers a list of words used to fill in the sentences when generating the lorem ipsum.
    def register(type, words, fillers: [])
      registry[type.to_s] = Dictionnary.new(words, fillers: fillers)
    end

    # Retrieves a dictionnary given its type.
    #
    # @param [String,Symbol] type the name of the dictionnary to retrieve
    # @return [Dictionnary,nil] the dictionnary registered for this name. nil if no dictionnary was registered for this type.
    def [](type)
      registry[type.to_s]
    end

    private

    attr_reader :registry
  end
end
