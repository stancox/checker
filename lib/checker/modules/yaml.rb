require 'yaml'

module Checker
  module Modules
    class Yaml < Base
      extensions 'yaml', 'yml'
      private
      def check_one(file, opts = {})
        ret = begin
          YAML.load_file(file)
          true
        rescue Exception => e
          puts e
          false
        end
        ret
      end
    end
  end
end
