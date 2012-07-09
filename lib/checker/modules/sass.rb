module Checker
  module Modules
    class Sass
      def self.check
        puts ">> Sass <<"

        unless Sass.check_for_executable
          puts "sass executable NOT FOUND, OMITTING..."
          return true
        end

        files = Utils.files_modified
        files.delete_if {|f| !f.ends_with?(".scss") and !f.ends_with?(".sass")}

        files.map! do |f|
          puts "Checking #{f}..."
          Sass.check_one(f)
        end

        files.all_true?
      end

      def self.check_one(file)
        cmd = "sass #{file} > /dev/null"
        Utils.command(cmd, :use_bundler => true)
      end

      def self.check_for_executable
        return @exitstatus unless @exitstatus.nil?
        cmd = "sass -v"
        Utils.command(cmd, :use_bundler => true)
        @exitstatus = ($?.exitstatus == 0)
      end
    end
  end
end
