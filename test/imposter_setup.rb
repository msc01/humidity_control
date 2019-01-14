require 'HTTparty'
require_relative 'mountebank'
include Mountebank

mountebank

puts "Look at #{MOUNTEBANK_ADDRESS} for imposters..."
