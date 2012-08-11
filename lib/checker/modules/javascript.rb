module Checker
  module Modules
    class Javascript < Base
      extensions 'js'
      private
      def check_one(file)
        plain_command("jsl -process #{file}")
      end

      def check_for_executable
        silent_command('jsl -help:conf', :bundler => false)
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install jsl linter binary\n"
        str << "More info: http://www.javascriptlint.com/download.htm\n"
        str
      end

      # ignore exit status 1 - warnings
      def plain_command cmd, options={}
        system(cmd)
        exitstatus = $?.exitstatus == 0 || $?.exitstatus == 1
        show_output(exitstatus, options)
        exitstatus
      end
    end
  end
end
