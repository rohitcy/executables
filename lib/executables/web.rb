module Executables
  class Web
    def self.call(env)
      req = Rack::Request.new(env)
      case req.path_info
      when '/'
        executables = Executables::Collector.collect_executables.keys
        html = ERB.new(File.read(File.expand_path("#{File.dirname(__FILE__)}/../../web/dashboard.erb"))).result(binding)
        [200, {"Content-Type" => "text/html"}, [html]]
      when /executables/
        executable = req.params['executable']
        executable_meta = Executables::Collector.collect_executable_metadata(executable)
        html = ERB.new(File.read(File.expand_path("#{File.dirname(__FILE__)}/../../web/execute.erb"))).result(binding)
        [200, {"Content-Type" => "text/html"}, [html]]
      when /execute/
        begin
          executable_class = Object.const_get(req.params["executable_class"])
          executable_method = req.params["executable_method"]
          argumnets = req.params["argumnets"].try(:values) || []
          executable_class.new.send(executable_method, *(argumnets))
          response = "Executable executed successfully!"
        rescue Exception => e
          response = "Not able to execute executable, error message: #{e.message}"
        end
        [200, {"Content-Type" => "text/html"}, [response]]
      else
        [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
      end
    end
  end
end
