module Checker
  module Modules
    class RubyBestPractices < Base
      extensions 'rb'
      private
      def check_one(file, opts = {})
        exitstatus = plain_command("rails_best_practices --spec #{file}", :bundler => true)
        {:exitstatus => exitstatus, :success => (exitstatus == 0)}
      end
    end
  end
end
