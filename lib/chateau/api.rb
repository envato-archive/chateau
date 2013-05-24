require 'hipchat-api'

module Chateau
  class Api
    attr_reader :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def all_rooms
      with_exception_handling([]) do
        hipchat_api.rooms_list['rooms'] || []
      end
    end

    def rooms_matching(room_name)
      all_rooms.select{ |room_object| room_object['name'].include?(room_name) }
    end

    def room_exists?(room_name)
      rooms_matching(room_name).any?
    end

    def room_id_for(room_name)
      room_list = rooms_matching(room_name)
      room_list.first['room_id'] unless room_list.empty?
    end

    def send_message(room_id, from, text, options = {})
      with_exception_handling(nil) do
        hipchat_api.rooms_message(room_id, from, text)
      end
    end

    private

    def with_exception_handling(default_return_value, &block)
      begin
        yield
      rescue => e
        $stderr.puts "Unable to access HipChat API"
        $stderr.puts e.message
        $stderr.puts e.backtrace.join("\n")
        default_return_value
      end
    end

    def hipchat_api
      @hipchat_api ||= ::HipChat::API.new(configuration.api_key).tap do |h|
        h.set_timeout(configuration.timeout)
      end
    end
  end
end
