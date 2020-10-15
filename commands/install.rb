require './commands/base'

class Commands::Install < Commands::Base
  def call(graph)
    graph.install(args[0])
  end
end
