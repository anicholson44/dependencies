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
    unless @components.include?(node)
      @components << node 
      puts "  Installing #{node}."
    else
      puts "  #{node} is already installed."
    end
    if @edges.has_key?(node)
      @edges[node].each { |n| install(n) }
    end
  end

  def remove(node)
    if @components.include?(node)
      if @edges.values.any? { |deps| deps.include?(node) }
        puts "  #{node} is still needed."
      else
        @components.delete(node)
        puts "  Removing #{node}."
      end
    end
    if @edges.has_key?(node)
      @edges[node].each { |n| remove(n) }
    end
  end

  def list
    @components.each do |component|
      puts '  ' + component
    end
  end
end
