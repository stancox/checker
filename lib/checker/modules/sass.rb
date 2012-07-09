module Checker
  module Modules
    class Sass
      def self.check
        Utils.color("> Sass syntax <\n", :light_blue)

        unless Sass.check_for_executable
          Utils.color("sass executable NOT FOUND, OMITTING...\n", :magenta)
          return true
        end

        files = Utils.files_modified
        files.delete_if {|f| !f.ends_with?(".scss") and !f.ends_with?(".sass")}

        files.map! do |f|
          Utils.color("Checking #{f}...", :yellow)
          Sass.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        cmd = "sass #{file}"
        Utils.command(cmd, :use_bundler => true, :append => ">> /dev/null")
      end

      def self.check_for_executable
        return @exitstatus unless @exitstatus.nil?
        cmd = "sass -v"
        Utils.command(cmd, :use_bundler => true, :show_output => false, :append => ">> /dev/null")
        @exitstatus = ($?.exitstatus == 0)
      end
    end
  end
end
