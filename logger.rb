class Logger
  def initialize(max_depth = nil, indent = 2)
    @max_depth = max_depth
    @log = []
    @indent = indent
  end

  def log(string, depth = 0)
    log_string = "#{' ' * @indent}#{string}" unless @max_depth && depth > @max_depth
    @log << log_string
    puts log_string if log_string
  end

  def read
    @log
  end
end
