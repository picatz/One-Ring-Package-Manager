#!/usr/bin/env ruby

module Orpm
  def banner
    puts "ORPM ".bold + " One Ring Package Manager".bold.red
  end

  def poem
    puts
    puts "Brew for the Apple-kings under the sky,"
    puts "Aptitude for the Debian-lords in their halls of stone,"
    puts "Yellowdog for Red-Hatted Men doomed to die,"
    puts "Git for the Open Lord on his open throne"
    puts "In the Land of Terminals where the Hackers lie."
    puts "One Ring to rule them all, One Ring to find them,"
    puts "One Ring to bring them all and in the darkness bind them"
    puts "In the Land of Teminals where the Hackers lie."
    puts
  end

  def clear_screen
    system('clear')
  end
end
