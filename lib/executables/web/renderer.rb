module Executables
  module Web
    class Renderer
      class << self
        def render(request, template, bindings)
          ERB.new(File.read(File.expand_path("#{File.dirname(__FILE__)}/../../../web/views/#{template}.erb"))).result(binding)
        end
      end
    end
  end
end
