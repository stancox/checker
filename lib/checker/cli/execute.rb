class CoreExt
  def self.constantize(camel_cased_word)
    names = camel_cased_word.split('::')
    names.shift if names.empty? || names.first.empty?

    constant = Object
    names.each do |name|
      constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
    end
    constant
  end
end

class String
  def constantize
    CoreExt.constantize(self)
  end
end

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
