require 'chateau/version'
require 'chateau/configuration'
require 'chateau/api'
require 'chateau/room'

########################################################
# Chateau.configuration do |config|
#   config.api_key = "xxx"
#   config.default_sender = "foo"
#   config.default_room_name = "bar"
# end
#
# Chateau.default_room.message("blah")
########################################################
module Chateau
  class << self
    def configuration(&block)
      @configuration ||= Configuration.new.tap do |config|
        config.default_sender = "Hipchat Ruby Thinger"
        config.default_room_name = "default"
        config.timeout = 6
        yield(config) if block_given?
      end
    end
    alias_method :config, :configuration

    def default_room
      Room.new(configuration.default_room_name, api, configuration)
    end

    private

    def api
      Api.new(configuration)
    end
  end
end
