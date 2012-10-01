module Checker
  module Modules
    class Javascript < Base
      extensions 'js'
      private
      def check_one(file, opts = {})
        exitstatus = plain_command("jsl -process #{file}")
        {:exitstatus => exitstatus, :success => (exitstatus == 0 || exitstatus == 1)}
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

      def success?
        $?.exitstatus
      end

      def show_status(status)
        if status == 0
          print_success_message
        elsif status == 1
          print_warning_message
        else
          print_fail_message
        end
      end
    end
  end
end
