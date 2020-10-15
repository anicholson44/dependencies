require './graph'
require_relative './commands/factory'

class Dependencies
  def initialize(input)
    @input = input
    @graph = Graph.new
  end

  def run
    @input.each do |command_string|
      puts command_string
      command = Commands::Factory.create(command_string)
    end
  end
end
