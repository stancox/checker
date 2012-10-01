module Checker
  module Modules
    class ConsoleLog < Base
      extensions 'coffee', 'js'

      private
      def check_one(file, opts = {})
        exitstatus = !plain_command("grep -n \"console\\.log\" #{file}", :bundler => false)
        {:exitstatus => exitstatus, :success => true}
      end

      def show_status(success)
        if success
          print_success_message
        else
          print_warning_message
        end
      end
    end
  end
end
