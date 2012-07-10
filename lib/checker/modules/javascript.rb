module Checker
  module Modules
    class Javascript < Base
      extensions 'js'
      private
      def check_one(file)
        plain_command("jshint #{file}")
      end

      def check_for_executable
        command('jshint -v', :show_output => false, :append => ">> /dev/null 2>&1")
      end
    end
  end
end
