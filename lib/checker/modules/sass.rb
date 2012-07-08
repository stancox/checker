module Checker
  module Modules
    class Sass < Base
      def check
        puts ">> Sass <<"

        unless check_for_executable
          puts "sass executable NOT FOUND, OMITTING..."
          return true
        end

        files.select {|f| f.ends_with?(".scss") || f.ends_with?(".sass")}.map! do |f|
          puts "Checking #{f}..."
          check_one(f)
        end

        files.all_true?
      end

      def check_one(file)
        system("sass #{file} > /dev/null")
      end

      def check_for_executable
        cmd = "sass -v"
        system(cmd)
        $?.exitstatus == 0
      end
    end
  end
end
