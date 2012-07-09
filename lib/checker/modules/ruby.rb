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
        File.exists?(".rvmrc") && File.exists?(rvm_shell)
      end

      def rvm_shell
        File.join(ENV.fetch('rvm_path', ''), 'bin/rvm-shell')
      end

      def rvm_command(command)
        rvm_version = `echo $rvm_ruby_string`.chomp
        puts "Using '#{rvm_version}' version"
        cmd = "#{rvm_shell} '#{rvm_version}' -c '#{command}'"
        command cmd
      end
    end
  end
end
