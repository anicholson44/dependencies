require './commands/base'

class Commands::Depend < Commands::Base
  def call(graph)
    component = graph.find(args[0])
    component.depend(args[1..-1])
  end
end
