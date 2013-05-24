module Chateau
  class Room
    attr_reader :name, :api, :configuration

    def initialize(name, api, configuration)
      @name = name
      @api = api
      @configuration= configuration
    end

    def message(text, from = nil, options = {})
      from = from || configuration.default_sender
      room_id = find_room_id
      api.send_message(room_id, from, text, options) if room_id
    end

    private

    def find_room_id
      api.room_id_for(name)
    end
  end
end
