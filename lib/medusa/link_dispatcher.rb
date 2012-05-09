require_relative 'db.rb'
require_relative 'models.rb'
require_relative 'conf.rb'
require 'bunny'
require 'yaml'
require 'logger'


class Linkdisp
  
  def initialize
    @cnt = 0
    @bunny= Bunny.new(:logging => false )
    @bunny.start
    @exch = @bunny.exchange("links")
    @queue = @bunny.queue("links")
    @queue.bind(@exch, :key=>"links")
    @logger = Logger.new(STDOUT)
  end

  def run
    loop do
      queue_length = @queue.message_count
      puts "#{queue_length} items in the link queue."
      if queue_length < LINK_REFILL_LOW_LIMIT
        pull_new_data
        feed_rabbit
      end
      STDOUT.puts "Refill complete"
      sleep LINK_REFILL_SLEEP
    end
  end


  def pull_new_data
    @new_links = Link.where(:state => LINK_STATE_UNPROCESSED).limit LINK_REFILL_AMT
  end


  def feed_rabbit
    @new_links.each do |link|
      @cnt = @cnt + 1
      ylink = link.to_yaml
      @exch.publish(ylink, :key=>"links")
      link.state = LINK_STATE_PROCESSING
      link.save
      @logger.log @cnt
      STDOUT.puts @cnt
    end

  end



end

ld=Linkdisp.new
ld.run

