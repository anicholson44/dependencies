module Commands
end

class Commands::Base
  def initialize(args = [])
    @args = args
  end

  def call(graph)
    raise NotImplementedError
  end
end
