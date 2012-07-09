module Checker
  module Modules
    class Pry < Base
      extensions 'rb'

      private
      def check_one file
        [check_for_binding_pry(file), check_for_binding_remote_pry(file)].all_true?
      end

      def check_for_binding_pry(file)
        result = `grep -n "binding\\.pry" #{file}`.chomp

        unless result.empty?
          puts "FAIL #{file} found occurence of 'binding.pry'"
          puts result
        end

        result.empty?
      end

      def check_for_binding_remote_pry(file)
        result = `grep -n "binding\\.remote_pry" #{file}`.chomp

        unless result.empty?
          puts "FAIL #{file} -> found occurence of 'binding.remote_pry'"
          puts result
        end

        result.empty?
      end
    end
  end
end
