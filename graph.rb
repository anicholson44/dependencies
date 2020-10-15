require 'set'

class Graph
  def initialize
    @components = Set.new
    @edges = {}
  end

  def depend(node, dependencies)
    @edges[node] = dependencies
  end

  def install(node)
    @components << node unless @components.include?(node)
    if @edges.has_key?(node)
      @edges[node].each { |n| install(n) }
    end
  end

  def remove(node)
    @components.delete(node)
    if @edges.has_key?(node)
      @edges[node].each { |n| remove(n) }
    end
  end

  def list
    @components.each do |component|
      puts component
    end
  end
end
