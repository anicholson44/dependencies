require './commands/base'

class Commands::End < Commands::Base
  def call(graph)
    exit(0)
  end
end
