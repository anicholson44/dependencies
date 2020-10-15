require 'minitest/autorun'
require 'byebug'
require './input'
require './dependencies'

class DependenciesTest < Minitest::Test
  def test_dependencies    
    input = Input.read
    dependencies = Dependencies.new(input)
    dependencies.run
    byebug
  end
end
