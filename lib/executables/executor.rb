module Executables
  class Executor
    class << self
      def execute(executable_class, executable_method, arguments, async=false)
        if async
          ExecutorJob.perform_later(executable_class, executable_method, arguments)
        else
          ExecutorJob.perform_now(executable_class, executable_method, arguments)
        end
      end
    end

    private
    class ExecutorJob < ActiveJob::Base
      def perform(executable_class, executable_method, arguments)
        if executable_class.instance_methods.include?(executable_method)
          executable_class.new.send(executable_method, *(arguments))
        else
          executable_class.send(executable_method, *(arguments))
        end
      end
    end
  end
end
