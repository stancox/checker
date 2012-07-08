module Checker
module Utils
  def files_modified
    @files_modified ||= `git status --porcelain | egrep "^(A |M |R ).*" | awk ' { if ($3 == "->") print $4; else print $2 } '`.split
    @files_modified.dup
  end
end
end
