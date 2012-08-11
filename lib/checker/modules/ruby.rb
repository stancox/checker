module Checker
  module Modules
    class Ruby < Base
      extensions 'rb'
      private
      def check_one(file)
        plain_command("ruby -c #{file}", :append => ">> /dev/null")
      end
    end
  end
end
