require 'set'

class Graph
  attr_reader :logger
  
  def initialize(logger)
    @edges = {}
    @components = ComponentSet.new(@edges)
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
    @components.commit!
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
    @components.commit!
  end

  def list
    @components.each do |component|
      logger.log(component, 1)
    end
  end

  class ComponentSet
    def initialize(dependencies)
      @set = Set.new
      @modified_set = Set.new
      @dependencies = dependencies
    end

    def <<(component)
      @modified_set << component
    end

    def delete(component)
      @modified_set.delete(component)
    end

    def include?(component)
      @modified_set.include? component
    end

    def each(&block)
      @set.each &block
    end

    def commit!
      removed = @set - @modified_set
      new_set = @set
      if removed.any?
        removed.reject! { |component| @dependencies.values.any? { |deps| deps.include?(component) } }
        new_set = @set - removed
      end
      added = @modified_set - @set
      if added.any?
        new_set = new_set + added
      end
      @set = new_set
    end
  end
end
