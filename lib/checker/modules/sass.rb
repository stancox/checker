module Checker
  module Modules
    class Sass < Base
      include ::Checker::Utils
      def check
        puts ">> Sass <<"

        unless check_for_executable
          puts "sass executable NOT FOUND, OMITTING..."
          return true
        end

        files = files_modified
        files.delete_if {|f| !f.ends_with?(".scss") and !f.ends_with?(".sass")}

        files.map! do |f|
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
