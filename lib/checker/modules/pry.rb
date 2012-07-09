module Checker
  module Modules
    class Pry < Base

      private
      def check_one file
        [check_for_binding_pry(file), check_for_binding_remote_pry(file)].all_true?
      end

      def check_for_binding_pry(file)
        result = `grep -n "binding\\.pry" #{file}`.chomp

        unless result.empty?
          puts " pry -> FAIL, ".red
          puts result
        else
          print " pry -> OK, ".green
        end

        result.empty?
      end

      def check_for_binding_remote_pry(file)
        result = `grep -n "binding\\.remote_pry" #{file}`.chomp

        unless result.empty?
          puts " remote_pry -> FAIL".red
          puts result
        else
          print " remote_pry -> OK".green
        end
        puts ""

        result.empty?
      end
    end
  end
end
