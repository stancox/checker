module Checker
  module Modules
    class Ruby < Base
      extensions 'rb'
      private
      def check_one(file)
        if use_rvm?
          rvm_command("ruby -c #{file}")
        else
          command("ruby -c #{file}")
        end
      end

      def use_rvm?
        File.exists?(".rvmrc")
      end

      def rvm_command(command)
        rvm_version = `echo $rvm_ruby_string`.chomp
        puts "Using '#{rvm_version}' version"
        cmd = "$rvm_path/bin/rvm-shell '#{rvm_version}' -c '#{command}'"
        command cmd
      end
    end
  end
end
