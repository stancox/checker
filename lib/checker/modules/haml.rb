module Checker
  module Modules
    class Haml
      def self.check
        Utils.color("> HAML syntax <\n", :light_blue)

        files = Utils.files_modified
        files.delete_if {|f| !f.ends_with?(".haml")}

        files.map! do |f|
          Utils.color("Checking #{f}...", :yellow)
          Haml.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        Utils.plain_command("haml #{file} > /dev/null")
      end
    end
  end
end
