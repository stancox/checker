require 'colorize'
require 'digest/md5'

require 'checker/core_ext'
require 'checker/version'

%w[base ruby haml slim pry coffeescript javascript sass yaml conflict].each do |mod|
  require "checker/modules/#{mod}"
end

def debug_mode?
  ENV['CHECKER_DEBUG'].to_s == "1"
end

if debug_mode?
  puts "Running checker with debug mode!".colorize(:yellow)
end