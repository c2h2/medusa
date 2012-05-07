require_relative 'db.rb'
require_relative 'models.rb'
require_relative 'conf.rb'


1000.times do |i|
  l=Link.new
  l.url = (0...8).map{65.+(rand(25)).chr}.join
  l.state = 0
  l.save
  puts "#{i} saved!"
end
