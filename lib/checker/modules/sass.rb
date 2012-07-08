module Checker
  module Modules
    class Sass < Base
      extensions 'scss', 'sass'
      private
      def check_one(file)
        system("sass #{file} > /dev/null")
      end

      def check_for_executable
        command("sass -v")
      end
    end
  end
end
