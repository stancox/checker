require 'checker'

module Checker
  class CLI
    class << self
      def execute
        if ARGV.size == 0
          modules = get_modules_to_check
        else
          if ARGV[0] == "install"
            Checker::Installator.install!
          elsif ARGV[0] == "help"
            Checker::Helper.show_help!
          elsif ARGV[0] == "modules"
            Checker::Helper.show_modules!(self.available_modules)
          else
            modules = ARGV.map(&:downcase)
          end
        end

        if modules.empty? || modules.include?('all')
          modules = available_modules
        end

        check_module_availability(modules) do |result|
          puts "Modules not available: #{result.join(", ")}.\n"
          puts "Available: all, #{available_modules.join(", ")}\n"
          puts "Check your git config checker.check\n"
          exit 1
        end

        module_instances = []
        files = modified_files
        modules.each do |mod|
          klass = "Checker::Modules::#{mod.classify}".constantize
          module_instances << klass.new(files.dup)
        end

        files_checked = module_instances.map(&:files_to_check).flatten.uniq
        puts "[ CHECKER #{Checker::VERSION} - #{files_checked.size} files ]".light_blue

        results = module_instances.map(&:check)
        exit (results.all_true? ? 0 : 1)
      end

      protected
      def available_modules
        Checker::Modules.constants.map(&:to_s).map(&:underscore) - ['base']
      end

      def check_module_availability(modules)
        result = modules - available_modules
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
        @modified_files ||= `git status --porcelain | egrep "^(A|M|R).*" | awk ' { if ($3 == "->") print $4; else print $2 } '`.split
      end
    end
  end
end
