module Checker
  module Modules
    class Coffeescript < Base
      extensions 'coffee'
      private
      def check_one(file, opts = {})
        exitstatus = plain_command("cat #{file} | egrep -v '^//=' | coffee -sc > /dev/null")
        {:exitstatus => exitstatus, :success => (exitstatus == 0)}
      end

      def check_for_executable
        silent_command('coffee -v', :bundler => false)
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install coffeescript from npm: 'npm install -g coffee-script'\n"
        str << "More info: https://github.com/jashkenas/coffee-script/\n"
        str
      end
    end
  end
end
