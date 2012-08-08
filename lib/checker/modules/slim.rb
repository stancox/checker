module Checker
  module Modules
    class Slim < Base
      extensions 'slim'
      private
      def check_one(file)
        plain_command("slimrb --compile #{file} >> /dev/null")
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install slim from rubygems: 'gem install slim'\n"
        str
      end
    end
  end
end
