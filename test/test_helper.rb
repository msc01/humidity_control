require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter 'version.rb'
  coverage_dir 'test/coverage'
end

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/humidity_control'
require_relative 'mountebank'
