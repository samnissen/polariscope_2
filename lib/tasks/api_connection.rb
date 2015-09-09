# http://stackoverflow.com/a/14552936/1651458

require "net/http"
require "uri"

class APIConnection
 VERB_MAP = {
   :get    => Net::HTTP::Get,
   :post   => Net::HTTP::Post,
   :put    => Net::HTTP::Put,
   :delete => Net::HTTP::Delete
 }

 API_ENDPOINT = "http://localhost:4000"

 attr_reader :http

 def initialize(endpoint = API_ENDPOINT)
   uri = URI.parse(endpoint)
   @http = Net::HTTP.new(uri.host, uri.port)
 end

 def request(method, path, params)
   case method
   when :get
     full_path = path_with_params(path, params)
     request = VERB_MAP[method].new(full_path)
   else
     request = VERB_MAP[method].new(path)
     request.set_form_data(params)
   end

   http.request(request)
 end

 private

 def path_with_params(path, params)
   encoded_params = URI.encode_www_form(params)
   [path, encoded_params].join("?")
 end

end
