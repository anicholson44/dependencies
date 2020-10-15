require './commands/depend'
require './commands/end'
require './commands/install'
require './commands/list'
require './commands/remove'

class Commands::Factory
  @@commands = {
    depend: Commands::Depend,
    end: Commands::End,
    install: Commands::Install,
    list: Commands::List,
    remove: Commands::Remove 
  }

  def self.create(string)
    input = string.split(' ')
    command = input[0].downcase.to_sym
    args = input[1..-1]
    @@commands[command].new(args)
  end
end
