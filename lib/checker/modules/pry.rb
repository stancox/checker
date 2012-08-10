module Checker
  module Modules
    class Pry < Base

      private
      def check_one file
        results = [check_for_binding_pry(file), check_for_binding_remote_pry(file)].select { |o| o.to_s.size > 0 }
        show_output(results.empty?)
        print results.map{ |r| "#{r}\n"}.join
        results.empty?
      end

      def check_for_binding_pry(file)
        `grep -n "binding\\.pry" #{file}`.chomp
      end

      def check_for_binding_remote_pry(file)
        `grep -n "binding\\.remote_pry" #{file}`.chomp
      end
    end
  end
end
