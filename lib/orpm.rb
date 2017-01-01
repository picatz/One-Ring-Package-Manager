require "orpm/helpers"
require "orpm/package"
require "orpm/packages"
require "orpm/version"

require 'open3'
require 'trollop'
require 'yaml'
require 'colorize'
require 'optparse'
require 'pry'

module Orpm
  # The Manager class performs the majority of 
  # the logic of this application.
  class Manager
    attr_reader :packages

    def initialize(args={})
      @packages = Packages.new
    end

    def debug
      binding.pry
    end

  end
end
