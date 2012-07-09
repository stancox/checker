module Checker
  module Modules
    class Haml < Base
      extensions 'haml'
      private
      def check_one(file)
        plain_command("haml --check #{file} >> /dev/null")
      end
    end
  end
end
