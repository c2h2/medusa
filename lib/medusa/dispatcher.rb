require_relative 'db.rb'
require_relative 'models.rb'

puts Link.all

link=Link.new
link.url ="asdf"
link.save

puts Link.all
