require './commands/base'

class Commands::Depend < Commands::Base
  def call(graph)
    graph.depend(args[0], args[1..-1])
  end
end
