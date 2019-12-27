module Requests
  module JsonHelpers
    def parse_response_json
      JSON.parse(last_response.body)
    end
  end
end
