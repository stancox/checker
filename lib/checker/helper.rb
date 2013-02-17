module Checker
  class Helper
    def self.show_help!
      puts "Checker version #{Checker::VERSION}"
      puts "* install - type 'checker install' to install git pre-commit-hook"
      puts "* reinstall - type 'checker reinstall' to purge current hook git pre-commit-hook and install new one"
      puts "* modules - type 'checker modules' to see available modules"
      puts "* checks  - type 'checker [module name]' to check your current git stage"
      puts "* help    - type 'checker help' to see this message :)"
      exit 0
    end

    def self.show_modules!(modules)
      puts "Available modules are: all, #{modules.join(", ")}"
      exit 0
    end
  end
end
