module Checker
  module Modules
    class Base < Struct.new(:files)
      def check
        print_module_header
        prepare_check
        check_executable or return true
        select_proper_files
        check_all_files
        valid?
      end

      def valid?
        @results.all_true?
      end

      private

      def print_module_header
        color "[ #{name} ]\n", :light_blue
      end

      def prepare_check
        @files_to_check = []
        @results = []
      end

      def check_executable
        if check_for_executable
          true
        else
          color "executable not found, skipping...\n", :magenta
          false
        end
      end

      def check_for_executable
        true
      end

      def select_proper_files
        @files_to_check = self.files.select { |f|
          self.class.extensions.map { |ex| f.ends_with?(ex) }.any?
        }
      end

      def check_all_files
        @results = @files_to_check.map do |file|
          color "Checking #{file}...", :yellow
          check_one(file)
        end
      end

      def self.extensions *args
        @extensions ||= []
        if args.empty?
          @extensions
        else
          @extensions += args
        end
      end

      def plain_command(cmd, options = {})
        exitstatus = system(cmd)
        show_output(exitstatus, options)
        exitstatus
      end

      def command(cmd, options = {})
        if options[:use_bundler] == true
          if use_bundler?
            cmd = "bundle exec #{cmd}"
          end
        end

        cmd = rvm_command(cmd) if use_rvm?
        cmd << " #{options[:append]}" if options[:append]
        exitstatus = execute(cmd)
        show_output(exitstatus, options)
        exitstatus
      end

      def show_output(exitstatus, options)
        unless options[:show_output] == false
          if exitstatus
            puts " [OK]".green
          else
            puts " [FAIL]".red
          end
        end
      end


      def execute(cmd)
        system(cmd)
      end

      def color(str, color)
        print str.colorize(color) 
      end

      def name
        self.class.to_s.split('::').last.upcase
      end

      def use_bundler?
        File.exists?("Gemfile.lock") 
      end

      def use_rvm?
        File.exists?(".rvmrc") && File.exists?(rvm_shell)
      end

      def rvm_shell
        File.join(ENV.fetch('rvm_path', ''), 'bin/rvm-shell')
      end

      def rvm_command(command)
        rvm_version = `echo $rvm_ruby_string`.chomp
        "#{rvm_shell} '#{rvm_version}' -c '#{command}'"
      end
    end
  end
end
