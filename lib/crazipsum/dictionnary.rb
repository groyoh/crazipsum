# frozen_string_literal: true

module Crazipsum
  # Dictionnary is a simple struct with a #words and #fillers read-only
  # attributes.
  # It is used to initialize the Generator instance.
  class Dictionnary
    attr_reader :words, :fillers

    def initialize(words, fillers: [])
      @words = words
      @fillers = fillers
    end
  end
end
