require 'yaml'

module Checker
  module Modules
    class Yaml < Base
      extensions 'yaml', 'yml'
      private
      def check_one(file, opts = {})
        ret = begin
          YAML.load_file(file)
          {:exitstatus => 0, :success => true}
        rescue Exception => e
          puts e
          {:exitstatus => 1, :success => false}
        end
      end
    end
  end
end
