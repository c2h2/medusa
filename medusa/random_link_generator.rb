require_relative 'conf/db.rb'
require_relative 'models.rb'
require_relative 'conf/conf.rb'

Link.destroy_all
Page.destroy_all

1000.times do |i|
  l=Link.new
  l.url = "http://" + (0...4).map{'a'.ord.+(rand(25)).chr}.join + ".com"
  l.state = 0
  l.depth = 0
  l.save
  puts "#{i} saved!"
end
