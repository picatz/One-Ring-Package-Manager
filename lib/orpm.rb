require "orpm/helpers"
require "orpm/version"

require 'trollop'
require 'yaml'
require 'colorize'
require 'optparse'
require 'pry'

module Orpm
  # This class performs the majority of the logic
  # of this application.
  class OneRing

    # Pass in options; and load file.
    def initialize(options)
      @options = options
      @info = YAML.load_file("packages.yaml")
      # Immediate debug hop.
      debug if @options[:Debug]
    end

    # Easily access package name information.
    def packages
      @info.keys
    end

    # Check if a package exists or not.
    def package_exists?(name)
      if packages.include?(name)
        true
      else
        false
      end
    end

    # Search if a package can be found.
    def search(name)
      if package_exists?(name)
        puts "Package #{name} found."
      else
        puts "Package #{name} not found."
      end
    end

    # Parse out package information.
    def parse_package(package)
      info = {}
      info[:name] = package["name"]
      info[:apt] = package["install"]["apt"]
      info[:yum] = package["install"]["yum"]
      info[:brew] = package["install"]["brew"]
      info[:git] = package["install"]["git"]
      info[:script] = package["install"]["script"]
      info[:source] = package["source"]
      info[:description] = package["description"]
      info[:examples] = package["examples"]
      info[:help] = package["help"]
      info
    end

    # Retrieve package info if it exists.
    def package_info(name)
      if package_exists?(name)
        @info[name]
      else
        false
      end
    end

    # Show all information about a package, with some options.
    def show_info(package, install=true, source=true, desc=true, examples=true, help=true)
      info = parse_package(package_info(package))
      if info
        puts "PACKAGE".bold
        puts "Package: " + package
        puts "Name: " + info[:name]
        puts
        if install
          puts "INSTALLATION".bold
          puts "   Apt: " + info[:apt].to_s
          puts "   Yum: " + info[:yum].to_s
          puts "  Brew: " + info[:brew].to_s
          puts "   Git: " + info[:git].to_s
          puts "Script: " + info[:script].to_s
          puts "Source: " + info[:source].to_s
          puts
        end
        if desc
          puts "DESCRIPTION".bold
          puts info[:description].to_s
          puts
        end
        if examples
          puts "EXAMPLES".bold
          if info[:examples]
            info[:examples].each do |example|
              puts "  " + example[0]
              puts "  " + example[1]["description"]
              puts "  " + "$ ".bold + example[1]["command"]
              puts
            end
          end
          if help
            puts "HELP".bold
            puts info[:help]
            puts
          end
        end
      end
    end

    # Debug method is cool 'yo.
    def debug
      binding.pry
    end

  end
end
