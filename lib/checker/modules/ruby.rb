module Checker
  module Modules
    class Ruby 
      extend ::Checker::Utils
      def self.check
        puts ">> RUBY <<"
        
        files = files_modified
        files.delete_if {|f| !f.ends_with?(".rb")}

        files.map! do |f|
          print "Checking #{f}... "
          check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        if use_rvm?
          rvm_command("ruby -c #{file}")
        else
          command("ruby -c #{file}")
        end
      end
    end
  end
end
