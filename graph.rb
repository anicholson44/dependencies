require 'set'

class Graph
  attr_reader :logger
  
  def initialize(logger)
    @components = ComponentSet.new
    @edges = {}
    @logger = logger
  end

  def depend(node, dependencies)
    @edges[node] = dependencies
  end

  def install(node, depth = 0)
    if @edges.has_key?(node)
      @edges[node].each { |n| install(n, depth + 1) }
    end
    unless @components.include?(node)
      @components << node 
      logger.log("Installing #{node}.", depth)
    else
      logger.log("#{node} is already installed.", depth)
    end
  end

  def remove(node, depth = 0)
    if @edges.has_key?(node)
      @edges[node].each { |n| remove(n, depth + 1) }
    end
    if @components.include?(node)
      if @edges.values.any? { |deps| deps.include?(node) }
        logger.log("#{node} is still needed.", depth)
      else
        @components.delete(node)
        logger.log("Removing #{node}.", depth)
      end
    end
  end

  def list
    @components.each do |component|
      logger.log(component, 1)
    end
  end

  class ComponentSet
    def initialize
      @set = Set.new
    end

    def <<(component)
      @set << component
    end

    def delete(component)
      @set.delete(component)
    end

    def include?(component)
      @set.include? component
    end

    def each(&block)
      @set.each &block
    end
  end
end
