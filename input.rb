class Input
  def self.read(file = 'input.txt')
    File.readlines(file).map do |l|
      l.gsub("\n", '').gsub("\r", '')
    end
  end
end
