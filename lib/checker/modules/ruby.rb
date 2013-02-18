module Checker
  module Modules
    class Ruby < Base
      extensions 'rb'
      private
      def check_one(file, opts = {})
        exitstatus = plain_command("ruby -c #{file}", :bundler => false)
        {:exitstatus => exitstatus, :success => (exitstatus == 0)}
      end
    end
  end
end
