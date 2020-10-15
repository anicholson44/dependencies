require './graph'
require './logger'
require_relative './commands/factory'

class Dependencies
  attr_reader :logger 
  def initialize(input)
    @input = input
    @logger = Logger.new(1)
    @graph = Graph.new(@logger)
  end

  def run
    @input.each do |command_string|
      puts command_string
      command = Commands::Factory.create(command_string)
      command.call(@graph)
    end
  end
end
