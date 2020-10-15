require './commands/base'

class Commands::List < Commands::Base
  def call(graph)
    graph.list
  end
end
