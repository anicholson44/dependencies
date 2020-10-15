module Commands
end

class Commands::Base
  attr_reader :args
  def initialize(args = [])
    @args = args
  end

  def call(graph)
    raise NotImplementedError
  end
end
