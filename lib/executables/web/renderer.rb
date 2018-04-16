module Executables
  module Web
    class Renderer
      class << self
        def render(request, template, bindings)
          template_file = File.read(File.expand_path("#{File.dirname(__FILE__)}/../../../web/views/#{template}.erb"))
          layout_file = File.read(File.expand_path("#{File.dirname(__FILE__)}/../../../web/views/layout.erb"))
          sub_template_content = ERB.new(template_file).result(binding)
          content_with_layout = ERB.new(layout_file).result(binding)
        end
      end
    end
  end
end
