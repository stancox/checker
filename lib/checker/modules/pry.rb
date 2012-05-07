module Checker
  module Modules
    class Pry
      def self.check
        puts ">> PRY <<"

        files = Utils.files_modified

        files.map! do |f|
          puts "Checking #{f}... "
          [Pry.check_for_binding_pry(f), Pry.check_for_binding_remote_pry(f)].all_true?
        end

        files.all_true?
      end

      def self.check_for_binding_pry(file)
        result = `grep -n "binding.pry" #{file}`.chomp

        unless result.empty?
          puts "FAIL #{file} found occurence of 'binding.pry'"
          puts result
        end

        result.empty?
      end

      def self.check_for_binding_remote_pry(file)
        result = `grep -n "binding.remote_pry" #{file}`.chomp

        unless result.empty?
          puts "FAIL #{file} -> found occurence of 'binding.remote_pry'"
          puts result
        end

        result.empty?
      end
    end
  end
end
