require 'colorize'
require 'digest/md5'

require 'checker/core_ext'
require 'checker/version'

require "checker/modules/base"
require "checker/modules/ruby"
require "checker/modules/haml"
require "checker/modules/slim"
require "checker/modules/pry"
require "checker/modules/coffeescript"
require "checker/modules/javascript"
require "checker/modules/sass"
require "checker/modules/yaml"

def debug_mode?
  ENV['CHECKER_DEBUG'].to_s == "1"
end

if debug_mode?
  puts "Running checker with debug mode!".colorize(:yellow)
end