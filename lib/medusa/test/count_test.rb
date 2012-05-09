require 'bunny'

bunny= Bunny.new
bunny.start
exch = bunny.exchange("sss")
queue = bunny.queue("sss")
queue.bind(exch, :key=>"sss")

e2 = bunny.exchange("dummy")
q2 = bunny.queue("dummy")
q2.bind(e2, :key=>"dummy")

10000.times do |i|
  queue.pop
  q2.pop
end

1000.times do |i|
  exch.publish("asdf#{i}", :key => "sss")
  e2.publish("fdsa#{i}", :key => "dummy")
  puts "Queue Length = #{queue.message_count}"
  
  if i %2 == 0
    item = q2.pop
    puts "Q2 length = #{q2.message_count}"
    puts item[:payload]
  end


end
