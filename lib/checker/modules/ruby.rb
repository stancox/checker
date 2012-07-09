module Checker
  module Modules
    class Ruby
      def self.check
        Utils.color("> Ruby syntax <\n", :light_blue)
        
        files = Utils.files_modified
        files.delete_if {|f| !f.ends_with?(".rb")}

        files.map! do |f|
          Utils.color("Checking #{f}...", :yellow)
          Ruby.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        Utils.command("ruby -c #{file}", :append => ">> /dev/null")
      end
    end
  end
end
