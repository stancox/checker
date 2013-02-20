require 'colorize'
require 'digest/md5'

require 'checker/core_ext'
require 'checker/rvm'
require 'checker/version'
require 'checker/installator'
require 'checker/helper'
require 'checker/options'

%w[base ruby haml slim pry coffeescript javascript sass yaml conflict console_log rails_best_practices].each do |mod|
  require "checker/modules/#{mod}"
end

def debug_mode?
  ENV['CHECKER_DEBUG'].to_s == "1"
end

if debug_mode?
  puts "Running checker with debug mode!".colorize(:yellow)
end

def debug(msg)
  puts "[DEBUG] - #{msg}".colorize(:yellow) if debug_mode?
end

