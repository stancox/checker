require 'checker'

module Checker
  class CLI
    class << self
    def execute
      if ARGV.size == 0
        modules = get_modules_to_check
      else
        modules = ARGV.map(&:downcase)
      end

      if modules.empty? || modules.include?('all')
        modules = available_modules
      end

      check_module_availability(modules) do |result|
        puts "Modules not available: #{result.join(", ")}.\n"
        puts "Available: #{available_modules.join(", ")}\n"
        puts "Check your git config checker.check\n"
        exit 1
      end

      checked = []
      files = modified_files
      modules.each do |mod|
        klass = "Checker::Modules::#{mod.downcase.capitalize}".constantize
        checked << klass.new(files.dup).check
      end
      exit (checked.all_true? ? 0 : 1)
    end

    private
    def available_modules
      Checker::Modules.constants.map(&:to_s).map(&:downcase) - ['base']
    end

    def check_module_availability(modules)
      constants = available_modules
      result = modules - (constants & modules)
      unless result.empty?
        if block_given?
          yield(result)
        end
      end
    end

    def get_modules_to_check
      `git config checker.check`.chomp.split(",").map(&:strip)
    end

    def modified_files
      @modified_files ||= `git status --porcelain | egrep "^(A |M |R ).*" | awk ' { if ($3 == "->") print $4; else print $2 } '`.split
    end
    end
  end
end
