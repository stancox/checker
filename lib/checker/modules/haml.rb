module Checker
  module Modules
    class Haml < Base
      extensions 'haml'
      private
      def check_one(file)
        plain_command("haml --check #{file} >> /dev/null")
      end

      def check_for_executable
        command("haml -v", :use_bundler => true, :show_output => false, :append => ">> /dev/null 2>&1")
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install haml from rubygems: 'gem install haml'\n"
        str
      end
    end
  end
end
