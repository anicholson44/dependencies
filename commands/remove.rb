require './commands/base'

class Commands::Remove < Commands::Base
  def call(graph)
    graph.remove(args[0])
  end
end
