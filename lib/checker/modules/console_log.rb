module Checker
  module Modules
    class ConsoleLog < Base
      extensions 'coffee', 'js'

      private
      def check_one(file, opts = {})
        exitstatus = plain_command("grep -n \"console\\.log\" #{file}", :bundler => false)
        ## needs to revert exit status
        ## if 0 returns then found console.log, so it's a warning :)
        exitstatus = (exitstatus - 1).abs

        {:exitstatus => exitstatus, :success => true}
      end

      def show_status(success)
        if success == 0
          print_success_message
        else
          print_warning_message
        end
      end
    end
  end
end
