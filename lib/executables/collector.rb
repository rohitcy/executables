module Executables
  class Collector
    class << self
      def collect_executables
        Executables.executable_directories.
          each_with_object({}) do |dir, executables|
          executable_absolute_path = (Executables.root_directory + dir).to_s
          Dir[executable_absolute_path + '/**/*.rb'].each do |executable|
            executable_class_name = executable.sub(executable_absolute_path, '').split('/').map(&:camelcase).join('::').gsub('.rb', '')
            executables[executable_class_name] = executable
          end
        end
      end

      def collect_executable_metadata(executable)
        executable_meta = {}
        begin
          executable = Object.const_get(executable)
        rescue Exception
          require Executables::Collector.collect_executables[executable]
          executable = Object.const_get(executable)
        end
        all_methods = executable.methods(false)
        instance_methods = executable.instance_methods(false)
        if all_methods.size > instance_methods.size
          executable_methods = all_methods - instance_methods
          executable_methods.each do |method|
            executable_meta[method] = executable.method(method).
                                      parameters.map(&:last)
          end
        else
          executable_methods = instance_methods - all_methods
          executable_methods.each do |method|
            executable_meta[method] = executable.instance_method(method).
                                      parameters.map(&:last)
          end
        end
        executable_meta
      end
    end
  end
end
