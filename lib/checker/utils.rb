module Checker
module Utils
  def files_modified
    @files_modified ||= `git status --porcelain | egrep "^(A |M |R ).*" | awk ' { if ($3 == "->") print $4; else print $2 } '`.split
    @files_modified.dup
  end

  def available_modules
    Checker::Modules.constants.map(&:to_s).map(&:downcase) - ['base']
  end

  def check_module_availability(modules)
    constants = available_modules
    result = modules - (constants & modules)
    unless result.empty?
      if block_given?
        yield(result)
      end
    end
  end

  def get_modules_to_check
    `git config checker.check`.chomp.split(",").map(&:strip)
  end
end
end
