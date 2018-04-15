require "executables/version"
require "executables/collector"
require "executables/web"

module Executables
  class << self
    attr_accessor :root_directory, :executable_directories, :executable_files

    def configure
      yield self
    end
  end
end
