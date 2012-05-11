require_relative 'db.rb'
require_relative 'models.rb'
require_relative 'conf.rb'
require_relative 'aux.rb'
require 'bunny'
require 'yaml'
require 'open-uri'
require 'nokogiri'

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
    @queue2.bind(@exch2, :key=>"pages")
  end

  def run
    loop do
      process_one_page
    end
  end

  def process_one_page
    page_port = get_a_job
    Util.log "Getting a page #{page_port}"
    if !page_port.nil?
      page = page_port.get_page

      urls = page.parse_page
      return if urls.nil?
      urls.each do |url|
        save_url page.url, url
      end
      begin
        page.save
      rescue
        #save utf-8 invliad problems.
      end
    else
      Util.log "Empty queue, sleep for a while"
      sleep 0.5
    end
  end

  def valid_url? url
    (url.to_s =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix)
  end

  def save_url page_url, url
    #determine if valid
    url = Link.full_url(page_url, url)
    Util.log "Saving #{url}"
    unless valid_url?(url)
      return
    end
    #determine if intersted. (domain, regex, and similarity)
    unless Rule.ok?(url)
      #return
    end

    #determine if duplicated.
    if Link.exists? url
      return
    end

    Util.log "Saved #{url}"
    l=Link.new
    l.url = url 
    l.state = LINK_STATE_UNPROCESSED
    l.save

  end

  
  def run
    loop do
      process_one_page
    end
  end

  def get_a_job
    item = @queue2.pop
    puts "Queue length = #{@queue2.message_count}"
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

