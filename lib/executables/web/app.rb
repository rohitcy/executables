module Executables
  module Web
    class App
      def self.call(env)
        request = Rack::Request.new(env)
        bindings = {}
        case request.path_info
        when '/'
          bindings['executables'] = Executables::Collector.collect_executables.keys
          html = Executables::Web::Renderer.render(request, 'dashboard', bindings)
          [200, {"Content-Type" => "text/html"}, [html]]
        when /executables/
          bindings['executable'] = request.params['executable']
          bindings['executable_meta'] = Executables::Collector.collect_executable_metadata(request.params['executable'])
          html = Executables::Web::Renderer.render(request, 'execute', bindings)
          [200, {"Content-Type" => "text/html"}, [html]]
        when /execute/
          begin
            executable_class = Object.const_get(request.params["executable_class"])
            executable_method = request.params["executable_method"]
            argumnets = request.params["argumnets"].try(:values) || []
            executable_class.new.send(executable_method, *(argumnets))
            response = "Executable executed successfully!"
          rescue Exception => e
            response = "Not able to execute executable, error message: #{e.message}"
          end
          [200, {"Content-Type" => "text/html"}, [response]]
        when /assets/
          begin
            asset_content = File.read(File.expand_path("#{File.dirname(__FILE__)}/../../../web/#{request.path_info}"))
            [200, {"Content-Type" => "text/css;charset=utf-8"}, [asset_content]]
          rescue Exception => e
            [500, {"Content-Type" => "text/html"}, ["Can't find asset"]]
          end
        else
          [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
        end
      end
    end
  end
end
