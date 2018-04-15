module Executables
  class Collector
    class << self
      def collect_executables
        executables = {}
        Executables.executable_directories.each do |dir|
          executable_absolute_path = (Executables.root_directory + dir).to_s
          Dir[executable_absolute_path + '/**/*.rb'].each do |executable|
            executable_class_name = executable.sub(executable_absolute_path, '').split('/').map(&:camelcase).join('::').gsub('.rb', '')
            executables[executable_class_name] = executable
          end
        end
        executables
      end

      def collect_executable_metadata(executable)
        executable_meta = {}
        executable = Object.const_get(executable)
        (executable.instance_methods(false) - executable.methods(false)).each do |method|
          executable_meta[method] = executable.instance_method(method).parameters.map(&:last)
        end
        executable_meta
      end
    end
  end
end
