module Executables
  module Web
    class App
      def self.call(env)
        request = Rack::Request.new(env)
        bindings = {}
        begin
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
            execute_async = request.params["async"].present?
            executable_class = request.params["executable_class"]
            executable_method = request.params["executable_method"]
            argumnets = request.params["argumnets"].try(:values) || []
            response = Executables::Executor.execute(executable_class, executable_method, argumnets, execute_async)
            [200, {"Content-Type" => "text/html"}, [response]]
          when /assets/
            asset_content = File.read(File.expand_path("#{File.dirname(__FILE__)}/../../../web/#{request.path_info}"))
            [200, {"Content-Type" => "text/css;charset=utf-8"}, [asset_content]]
          else
            [404, {"Content-Type" => "text/html"}, ["I'm Lost!"]]
          end
        rescue => error
          bindings['error'] = error
          html = Executables::Web::Renderer.render(request, 'error', bindings)
          [500, {"Content-Type" => "text/html"}, [html]]
        end
      end
    end
  end
end
