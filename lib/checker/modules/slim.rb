module Checker
  module Modules
    class Slim < Base
      extensions 'slim'
      private
      def check_one(file)
        plain_command("slimrb --compile #{file} >> /dev/null")
      end

      def check_for_executable
        command("slimrb -v", :use_bundler => true, :show_output => false, :append => ">> /dev/null 2>&1")
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install slim from rubygems: 'gem install slim'\n"
        str
      end
    end
  end
end
