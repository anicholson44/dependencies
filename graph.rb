require 'set'

class Graph
  attr_reader :logger
  
  def initialize(logger)
    @edges = {}
    @components = Set.new
    @logger = logger
  end

  def depend(node, dependencies)
    @edges[node] = dependencies
  end

  def install(node, depth = 0)
    unless @components.include?(node)
      @components << node 
      logger.log("Installing #{node}.", depth)
    else
      logger.log("#{node} is already installed.", depth)
    end
    if @edges.has_key?(node)
      @edges[node].each { |n| install(n, depth + 1) }
    end
  end

  def remove(node, depth = 0)
    if @components.include?(node)
      if (parents = @components.select { |p| @edges[p] && @edges[p].include?(node) }).any?
        logger.log("#{node} is still needed by #{parents}.", depth)
      else
        @components.delete(node)
        logger.log("Removing #{node}.", depth)
      end
    end
    if @edges.has_key?(node)
      @edges[node].each { |n| remove(n, depth + 1) }
    end
  end

  def list
    @components.each do |component|
      logger.log(component, 1)
    end
  end
end
