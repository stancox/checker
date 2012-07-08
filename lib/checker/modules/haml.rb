module Checker
  module Modules
    class Haml
      extend ::Checker::Utils
      def self.check
        puts ">> HAML <<"

        files = files_modified
        files.delete_if {|f| !f.ends_with?(".haml")}

        files.map! do |f|
          print "Checking #{f}... "
          Haml.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        system("haml --check #{file}")
      end
    end
  end
end
