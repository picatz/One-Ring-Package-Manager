module Orpm

  # Packages contains the main logic to house the different
  # packages manages by Orpm. It essentially acts as a nice
  # container to help wrangle what happens inside of an 
  # ORPM Package object.
  class Packages
    # The information about each package is managed as an array.
    attr_accessor :info

    def initialize(args={})
      @info = Array.new
    end

    # batch_parse() will handle parsing a single yaml file,
    # multiple yaml files, or simply parsed package info
    # and try to create a package from that data in bulk.
    # == Example
    #
    #   Typical usage:
    #   packages = Packages.new
    #   packages.batch_parse(file: "packages.yaml")
    #   
    def batch_parse(args={})
      packages_info = yaml_loader(args)
      packages_info.each do |package_info|
        info << create_package(package_info)
      end
      true
    end

    # search() handles the search functionality for packages,
    # being able to search for packages by their attributes.
    #
    # == Example
    #
    #   Typical usage:
    #   packages = Packages.new
    #   packages.batch_parse(file: "packages.yaml")
    #   packages.search(name: "nmap")
    #   # => Orpm::Package
    #   packages.search(name: "nmap").installed?
    #   # => true
    #
    def search(args={})
      results = []
      if args[:name]
        info.each do |package|
          # TODO: probbaly change this to an extact match
          # or add a new args modifier to change behavior.
          if args[:name].include? package.name
            return package unless args[:multi]
            results << package
          end
        end
      end
      results.empty? ? false : results
    end

    def add_package(args={})
      package_info = yaml_loader(args)
      info << create_package(package_info)
    end

    private

    def yaml_loader(args={})
      if args[:file]
        packages_info = YAML.load_file(args[:file])
      elsif args[:files]
        packages_info = {}
        args[:files].each do |file|
          file_info = YAML.load_file(file)
          packages_info.merge!(file_info)
        end
      else
        raise "Need to specify an file, or files to parse."
      end
      packages_info 
    end

    def create_package(info)
      package = Package.new
      package.parse(info: info)
      package
    end

  end

end
