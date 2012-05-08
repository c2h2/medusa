require_relative 'db.rb'
require_relative 'models.rb'
require_relative 'conf.rb'
require_relative 'aux.rb'
require 'bunny'
require 'yaml'
require 'logger'
require 'open-uri'

class Pageworker
  
  def initialize host
    @cnt = 0
    @bunny = Bunny.new(:logging => false, :host=>host )
    @bunny.start
    @exch  = @bunny.exchange("links")
    @queue = @bunny.queue("links")
    @queue.bind(@exch, :key=>"links")
    
    @exch2  = @bunny.exchange("pages")
    @queue2 = @bunny.queue("pages")
    @queue2 = @queue.bind(@exch2, :key=>"pages")
  end

  def run
    loop do
      process_one_page
    end
  end

  def process_one_page
    page_port = get_a_job
    if !page_port.nil?
      page = page_port.get_page

      urls = page.parse
      urls.each do |url|
        save_url url
      end
    end
  end

  def save_url
    #determine if valid

    
    #determine if intersted. (domain, regex, and similarity)
    

    #determine if duplicated.

  end

  
  def run
    loop do
     else
        #no outstanding job
        sleep 10
      end
    end
  end

  def get_a_job
    item = @queue2.pop
    if item[:payload].is_a? String
      page_port = YAML::load item[:payload]
    else
      page_port = nil
    end
    page_port
  end

end

lw=Pageworker.new "localhost"
lw.run

