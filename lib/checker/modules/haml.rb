module Checker
  module Modules
    class Haml < Base
      extensions 'haml'
      private
      def check_one(file)
        plain_command("haml #{file} > /dev/null")
      end
    end
  end
end
