require 'minitest/autorun'
require 'byebug'
require './input'
require './dependencies'

class DependenciesTest < Minitest::Test
  def test_dependencies    
    input = Input.read
    Dependencies.new(input).run
  end
end
