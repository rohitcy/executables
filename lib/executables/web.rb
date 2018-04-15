module Executables
  class Web
    def self.call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/'
        [200, {"Content-Type" => "text/html"}, ['Hello World!']]
      else
        [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
      end
    end
  end
end
