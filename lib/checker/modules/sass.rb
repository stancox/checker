module Checker
  module Modules
    class Sass < Base
      extensions 'scss', 'sass'
      private
      def check_one(file)
        command("sass #{file}", :use_bundler => true, :append => ">> /dev/null")
      end

      def check_for_executable
        command("sass -v", :use_bundler => true, :show_output => false, :append => ">> /dev/null 2>&1")
      end

      def dependency_message
        str = "Executable not found\n"
        str << "Install sass from rubygems: 'gem install sass'\n"
        str << "Sass requires haml to work properly: 'gem install haml'\n"
        str
      end
    end
  end
end
