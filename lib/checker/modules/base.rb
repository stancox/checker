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
        puts "[ #{name} ]"
      end

      def prepare_check
        @files_to_check = []
        @results = []
      end

      def check_executable
        if check_for_executable
          true
        else
          puts "executable not found, skipping..."
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
          puts "Checking #{file}... "
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

      def command(cmd)
        system(cmd)
      end

      def name
        self.class.to_s.split('::').last.upcase
      end
    end
  end
end
