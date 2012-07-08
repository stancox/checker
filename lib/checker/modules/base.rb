module Checker
  module Modules
    class Base
      def use_rvm?
        File.exists?(".rvmrc")
      end

      def rvm_command(command)
        rvm_version = `echo $rvm_ruby_string`.chomp
        puts "Using '#{rvm_version}' version"
        cmd = "$rvm_path/bin/rvm-shell '#{rvm_version}' -c '#{command}'"
        command cmd
      end

      def command(cmd)
        system(cmd)
      end
    end
  end
end
