class Logger
  def initialize(max_depth = nil)
    @max_depth = max_depth
    @log = []
  end

  def log(string, depth = 0)
    log_string = "#{' ' * depth}#{string}" unless @max_depth && depth > @max_depth
    @log << log_string
    puts log_string if log_string
  end
end
