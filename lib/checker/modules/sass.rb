module Checker
  module Modules
    class Sass < Base
      extensions 'scss', 'sass'
      private
      def check_one(file, opts = {})
        plain_command("sass #{"--scss" if opts[:extension] == ".scss"} -c #{file}")
      end

      def check_for_executable
        silent_command("sass -v")
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
