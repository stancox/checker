module Checker
  module Modules
    class Sass < Base
      extensions 'scss', 'sass'
      private
      def check_one(file)
        command("sass #{file} > /dev/null", :use_bundler => true, :append => ">> /dev/null")
      end

      def check_for_executable
        command("sass -v", :use_bundler => true, :show_output => false, :append => ">> /dev/null 2>&1")
      end
    end
  end
end
