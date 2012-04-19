class Utils
  def self.files_modified
    @files_modified ||= `git status --porcelain | egrep "^(A |M |R ).*" | awk ' { if ($3 == "->") print $4; else print $2 } '`.split
    @files_modified.dup
  end

  def self.use_rvm?
    File.exists?(".rvmrc")
  end

  def self.rvm_command(command)
    rvm_version = `echo $rvm_ruby_string`.chomp
    puts "Using '#{rvm_version}' version"
    cmd = "$rvm_path/bin/rvm-shell '#{rvm_version}' -c '#{command}'"
    Utils.command cmd
  end

  def self.command(cmd)
    system('echo ' + cmd)
    system(cmd)
  end

  def self.available_modules
    Checker::Modules.constants.map(&:to_s).map(&:downcase)
  end

  def self.check_module_availability(modules)
    constants = self.available_modules
    result = modules - (constants & modules)
    unless result.empty?
      if block_given?
        yield(result)
      end
    end
  end

  def self.get_modules_to_check
    `git config checker.check`.chomp.split(",").map(&:strip)
  end
end