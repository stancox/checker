module Checker
  module Modules
    class Base < Struct.new(:files)
      def check
        check_files_existing or return true
        print_module_header
        check_executable or return true
        check_all_files
        valid?
      end

      def valid?
        @results.all_true?
      end

      def files_to_check
        @files_to_check ||= begin
          if self.class.extensions.any?
            self.files.select { |f|
              self.class.extensions.map { |ex| f.ends_with?(".#{ex}") }.any?
            }
          else
            self.files
          end
        end
      end

      private

      def print_module_header
        color "[ #{name} - #{files_to_check.size} files ]\n", :light_blue
      end

      def dependency_message
        "Executable not found, skipping...\n"
      end

      def check_files_existing
        files_to_check.any?
      end

      def check_executable
        if check_for_executable
          true
        else
          color dependency_message, :magenta
          false
        end
      end

      def check_for_executable
        true
      end

      def check_all_files
        with_checker_cache do
          @results = files_to_check.map do |file_name|
            color "  Checking #{file_name}...", :yellow
            result = check_one_file(file_name)
            show_status(result)
            flush_and_forget_output(result)
            result
          end
        end
      end

      def check_one_file file_name
        checksum = ::Digest::MD5.hexdigest(file_name)
        checkout_file(file_name, checksum)
        check_one(checkout_file_name(checksum))
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
        cmd = parse_command(cmd, options)
        execute(cmd)
      end

      def silent_command(cmd, options = {})
        options = { :output => false }.merge(options)
        cmd = parse_command(cmd, options)
        execute(cmd)
      end

      def flush_and_forget_output(success)
        print @buffer.to_s unless success
        @buffer = ""
      end

      def show_status(success)
        if success
          puts " [OK]".green
        else
          puts " [FAIL]".red
        end
      end

      def execute(cmd)
        io = IO.popen(cmd)
        Process.wait(io.pid)
        @buffer ||= ""
        @buffer << io.read
        success?
      end

      def success?
        $? && $?.success?
      end

      def parse_command command, options
        options = { :bundler => true, :output => true }.merge(options)
        command = bundler_command(command) if use_bundler? && options[:bundler]
        command = rvm_command(command) if use_rvm?
        command << " > /dev/null" unless options[:output]
        "#{command} 2>&1"
      end

      def color(str, color)
        print str.colorize(color) if str.length > 0
      end

      def name
        self.class.to_s.split('::').last.upcase
      end

      def use_bundler?
        File.exists?("Gemfile.lock")
      end

      def bundler_command(command)
        "bundle exec #{command}"
      end

      def use_rvm?
        File.exists?(rvm_shell)
      end

      def rvm_command(command)
        rvm_path = ENV['rvm_path'].to_s
        rvm_gem  = ENV['GEM_HOME'].to_s
        rvm_version = rvm_gem.gsub(Regexp.new(rvm_path + "/gems/"), "")

        "#{rvm_shell} '#{rvm_version}' -c '#{command}'"
      end

      def rvm_shell
        File.join(ENV['rvm_path'].to_s, 'bin/rvm-shell')
      end

      def with_checker_cache
        begin
          `mkdir .checker-cache`
          yield if block_given?
        ensure
          `rm -rf .checker-cache > /dev/null 2>&1`
        end
      end

      def checkout_file file_name, target
        `git show :0:#{file_name} > #{checkout_file_name(target)} 2>/dev/null`
      end

      def checkout_file_name target
        ".checker-cache/#{target}"
      end
    end
  end
end
