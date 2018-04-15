module Executables
  class Web
    def self.call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/'
        executables = Executables::Collector.collect_executables.keys
        html = ERB.new(File.read(File.expand_path("#{File.dirname(__FILE__)}/../../web/dashboard.erb"))).result(binding)
        [200, {"Content-Type" => "text/html"}, [html]]
      else
        [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
      end
    end
  end
end
