require 'checker/core_ext'

Dir["lib/*.rb"].each do |file|
  require "checker/#{file}"
end
