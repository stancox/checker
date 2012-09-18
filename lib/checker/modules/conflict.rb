module Checker
  module Modules
    class Conflict < Base

      private
      def check_one(file, opts = {})
        [check_for_conflict_start(file), check_for_conflict_end(file)].all_true?
      end

      def check_for_conflict_start(file)
        !plain_command("grep -n \"<<<<<<< \" #{file}", :bundler => false)
      end

      def check_for_conflict_end(file)
        !plain_command("grep -n \">>>>>>> \" #{file}", :bundler => false)
      end
    end
  end
end
