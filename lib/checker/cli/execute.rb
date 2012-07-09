module Checker
  class CLI
    module Execute
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def execute
          if ARGV.size == 0
            modules = Utils.get_modules_to_check
          else
            modules = ARGV.map(&:downcase)
          end
          ## by default lets check all
          if modules.empty?
            modules = ["all"]
          end

          ## check all the modules
          if modules.include?("all")
            exit (Checker::Modules::All.check ? 0 : 1)
          else
            Utils.check_module_availability(modules) do |result|
              puts "Modules not available: #{result.join(", ")}.\n"
              puts "Available: #{Utils.available_modules.join(", ")}\n"
              puts "Check your git config checker.check\n"
              exit 1
            end

            checked = []
            modules.each do |mod|
              klass = "Checker::Modules::#{mod.downcase.capitalize}".constantize
              checked << klass.check
            end
            exit (checked.all_true? ? 0 : 1)
          end
        end
      end
    end
  end
end
