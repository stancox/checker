module Checker
  module Modules
    class Pry < Base

      private
      def check_one(file, opts = {})
        [check_for_binding_pry(file), check_for_binding_remote_pry(file)].all_true?
      end

      def check_for_binding_pry(file)
        !plain_command("grep -n \"binding\\.pry\" #{file}", :bundler => false)
      end

      def check_for_binding_remote_pry(file)
        !plain_command("grep -n \"binding\\.remote_pry\" #{file}", :bundler => false)
      end
    end
  end
end
