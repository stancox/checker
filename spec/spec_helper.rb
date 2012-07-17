$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

FIXTURES_PATH = File.join(File.dirname(__FILE__), "checker", "fixtures")

def fixture(dir, filename)
  "#{FIXTURES_PATH}/#{dir}/#{filename}"
end

require 'checker/cli'