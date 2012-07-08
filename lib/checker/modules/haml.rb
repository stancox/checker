module Checker
  module Modules
    class Haml < Base
      def check
        puts ">> HAML <<"

        files.select {|f| f.ends_with?(".haml")}.map! do |f|
          print "Checking #{f}... "
          check_one(f)
        end

        files.all_true?
      end

      def check_one(file)
        system("haml --check #{file}")
      end
    end
  end
end
