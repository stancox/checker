module Checker
  module Modules
    class Coffeescript < Base
      extensions 'coffee'
      def check_one(file)
        system("cat #{file} | egrep -v '^//=' | coffee -sc > /dev/null")
      end

      def check_for_executable
        command('coffee -v')
      end
    end
  end
end
