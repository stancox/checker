module Checker
  module Modules
    class Coffeescript < Base
      extensions 'coffee'
      private
      def check_one(file)
        plain_command("cat #{file} | egrep -v '^//=' | coffee -sc > /dev/null")
      end

      def check_for_executable
        command('coffee -v', :show_output => false, :append => ">> /dev/null 2>&1")
      end
    end
  end
end
