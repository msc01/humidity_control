# humidity_control
# ---
# Dependencies
require 'bundler/setup'
require 'httparty'
require 'logger'
require 'optparse'
require 'twilio-ruby'
require 'yaml'

require_relative 'humidity_control/alert'
require_relative 'humidity_control/config'
require_relative 'humidity_control/sensor'
require_relative 'humidity_control/version'

# Sets the loglevel
LOGGER = Logger.new(STDERR)
LOGGER.progname = 'humidityControl'
LOGGER.level = Logger::INFO # DEBUG, INFO, WARN
