module Orpm

  # Package contains the main logic to help manage the 
  # what happens inside of an ORPM package.
  class Package
    # The name of the package.
    attr_accessor :package_name
    attr_accessor :full_name

    # Rest of the package's info.
    attr_accessor :apt
    attr_accessor :yum
    attr_accessor :brew
    attr_accessor :git
    attr_accessor :script
    attr_accessor :source
    attr_accessor :description
    attr_accessor :examples
    attr_accessor :help

    def initialize(args={})
      parse(args[:file]) if args[:file]
    end

    def parse(args={})
      if args[:file]
        info = YAML.load_file(args[:file])
      elsif args[:info]
        info = args[:info]
      end
      begin
        # TODO: probably come back and re-assess this behavior
        @package_name = info[0]                       || false
        @full_name    = info[1]["name"]               || false
        @apt          = info[1]["install"]["apt"]     || false
        @yum          = info[1]["install"]["yum"]     || false
        @brew         = info[1]["install"]["brew"]    || false
        @git          = info[1]["install"]["git"]     || false
        @script       = info[1]["install"]["script"]  || false
        @source       = info[1]["source"]             || false
        @description  = info[1]["description"]        || false
        @examples     = info[1]["examples"]           || false
        @help         = info[1]["help"]               || false
      rescue => e
        raise "Malformed package information for #{info}!: #{e}"
      end
    end

    def name(args={})
      if args[:package]
        package_name
      elsif args[:full]
        full_name
      else
        package_name
      end
    end

    def show_info
      puts "PACKAGE".bold
      puts "Package: " + package_name
      puts "Name: " + full_name
      puts
      puts "INSTALLATION".bold
      puts "   Apt: " + apt.to_s
      puts "   Yum: " + yum.to_s
      puts "  Brew: " + brew.to_s
      puts "   Git: " + git.to_s
      puts "Script: " + script.to_s
      puts "Source: " + source.to_s
      puts
      puts "DESCRIPTION".bold
      if description?
        puts description
        puts
      else
        puts "None."
      end
      puts "EXAMPLES".bold
      if examples?
        examples.each do |example|
          puts "  " + example[0]
          puts "  " + example[1]["description"]
          puts "  " + "$ ".bold + example[1]["command"]
          puts
        end
      else
        puts "None."
      end
      puts "HELP".bold
      if help?	
        puts help
        puts
      else
        puts "None."
      end
    end

    def name?
      name ? true : false
    end

    def apt?
      apt ? true : false
    end

    def yum?
      yum ? true : false
    end

    def brew?
      brew ? true : false
    end

    def git?
      git ? true : false
    end

    def script?
      script ? true : false
    end

    def description?
      description ? true : false
    end

    def examples?
      description ? true : false
    end

    def help?
      help ? true : false
    end

    def installed?
      # TODO: fix weak check
      `which #{package_name}`
      $?.success?
    end

  end

end
