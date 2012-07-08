module Checker
  module Modules
    class Coffeescript < Base
      def check
        puts ">> Coffeescript <<"

        unless check_for_executable
          puts "coffee executable NOT FOUND, OMITTING..."
          return true
        end

        files.select {|f| f.ends_with?(".coffee")}.map! do |f|
          puts "Checking #{f}..."
          check_one(f)
        end

        files.all_true?
      end

      def check_one(file)
        system("cat #{file} | egrep -v '^//=' | coffee -sc > /dev/null")
      end

      def check_for_executable
        cmd = "coffee -v"
        system(cmd)
        $?.exitstatus == 0
      end
    end
  end
end
