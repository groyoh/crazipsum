# frozen_string_literal: true

require 'crazipsum/version'
require 'crazipsum/registry'

data_dir = File.expand_path('../data', __dir__)
DEFAULT_FILLERS = File.read(File.join(data_dir, 'fillers.txt')).split("\n")

# Ever wanted some dumber, crazier (fancier?) lorem ipsum? Here you go!
module Crazipsum
  module_function

  # Registers a new type of Dictionnary that can later be retrieved with Crazipsum().
  #
  # @param [String,Symbol] type a name for that dictionnary. This type will be
  #                        used later when calling `Crazipsum(type)`.
  # @param [Array<String>] words a list of words used when generating the lorem ipsum.
  # @param [Array<String>] fillers a list of words used to fill in the sentences when generating the lorem ipsum.
  def register(type, words, fillers: DEFAULT_FILLERS)
    Crazipsum::Registry.instance.register(type, words, fillers: fillers)
  end
end

# Returns a lorem ipsum generator which will generate lorem ipsums of the given
# type.
#
# There are a few default types registered:
# * `car_make`
# * `phobia`
# * `programming_language`
# * `animal`
# * `fruit`
# * `constellation`
# * `mineral`
# * `religion`
# * `country`
#
# You can register new types of lorem ipsum via `Crazipsum.register(type, words, fillers: fillers)`.
#
# @param type [Symbol,String] the type of lorem ipsum you'd like to generate.
# @return [Crazipsum::Generator] a funky lorem ipsum generator.
def Crazipsum(type) # rubocop:disable Naming/MethodName
  dictionnary = Crazipsum::Registry.instance[type]
  raise ArgumentError, 'unregistered ipsum type' if dictionnary.nil?

  Crazipsum::Generator.new(dictionnary)
end

Dir[File.join(data_dir, '*')].each do |file|
  type = File.basename(file, '.txt')
  next if type == 'fillers'

  file_content = File.read(file)
  words = file_content.split("\n")

  Crazipsum.register(type, words)
end
