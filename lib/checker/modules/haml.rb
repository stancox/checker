module Checker
  module Modules
    class Haml < Base
      extensions 'haml'
      def check_one(file)
        system("haml --check #{file}")
      end
    end
  end
end
