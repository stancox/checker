module Checker
  module Modules
    class Pry
      def self.check
        Utils.color("> binding.pry occurence <\n", :light_blue)

        files = Utils.files_modified

        files.map! do |f|
          Utils.color("Checking #{f}...", :yellow)
          [Pry.check_for_binding_pry(f), Pry.check_for_binding_remote_pry(f)].all_true?
        end

        files.all_true?
      end

      def self.check_for_binding_pry(file)
        result = `grep -n "binding.pry" #{file}`.chomp

        unless result.empty?
          puts " pry -> FAIL, ".red
          puts result
        else
          print " pry -> OK, ".green
        end

        result.empty?
      end

      def self.check_for_binding_remote_pry(file)
        result = `grep -n "binding.remote_pry" #{file}`.chomp

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
