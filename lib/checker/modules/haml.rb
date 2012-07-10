module Checker
  module Modules
    class Haml < Base
      extensions 'haml'
      private
      def check_one(file)
        plain_command("haml --check #{file} >> /dev/null")
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install haml from rubygems: 'gem install haml'\n"
        str
      end
    end
  end
end
