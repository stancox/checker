module Checker
  module Modules
    class Coffeescript
      def self.check
        Utils.color("> Coffeescript syntax <\n", :light_blue)

        unless Coffeescript.check_for_executable
          Utils.color("coffee executable NOT FOUND, OMITTING...\n", :yellow)
          return true
        end

        files = Utils.files_modified
        files.delete_if {|f| !f.ends_with?(".coffee")}

        files.map! do |f|
          Utils.color("Checking #{f}...", :yellow)
          Coffeescript.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        Utils.plain_command("cat #{file} | egrep -v '^//=' | coffee -sc > /dev/null")
      end

      def self.check_for_executable
        cmd = "coffee -v"
        system(cmd)
        $?.exitstatus == 0
      end
    end
  end
end
