require "executables/version"
require "executables/collector"
require "executables/web"
require "executables/executor"

module Executables
  class << self
    attr_accessor :root_directory, :executable_directories, :async_executor

    def configure
      yield self
    end
  end
end
