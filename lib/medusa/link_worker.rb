require_relative 'db.rb'
require_relative 'models.rb'
require_relative 'conf.rb'
require_relative 'aux.rb'
require 'bunny'
require 'yaml'
require 'logger'


class Linkworker
  
  def initialize host
    @cnt = 0
    @bunny = Bunny.new(:logging => false, :host=>host )
    @bunny.start
    @exch  = @bunny.exchange("links")
    @queue = @bunny.queue("links")
    @queue.bind(@exch, :key=>"links")
    
#    @bunny2 = Bunny.new(:host=>host)
  #  @exch2  = @bunny.exchange("pages")
   # @queue2 = @bunny.queue("pages")
   # @queue2 = @queue2.bind(@exch2, :key=>"pages")
  end

  def run
    loop do
      process_one_link
    end
  end

  def report page


  end

  def process_one_link
    link = get_a_job
    #if link is accquired successful
    unless link.nil?
      page = dl link
      #if page is dl'ed successful
      report page
    else
      Util.log "no more job, sleep for a while"
      sleep 5
    end
  end

  def dl link, remain_times = 3
    page = Page.new
    if remain_times <= 0
      Util.log "Error in DL #{link.url} really failed after #{3} times"
      return 
    end
    page.link = link
    Util.log "DL #{link.url}"
    sw=Stopwatch.new 
    begin
      Timeout::timeout(Conf.time(:network)) do
        open(url, hash) do |f|
          @doc     = f.read
          page.charset = f.charset
          page.mime    = f.content_type
          page.code    = f.status[0].to_i
          f.base_uri
          f.meta
          begin
            page.expires_at = Time.parse(f.meta["expires"])
          rescue => e
            #no expires found
          end
  
          begin
            page.etag = f.meta["etag"]
          rescue => e
            #no etag found
          end
    
          unless f.last_modified.nil?
            page.lm_at = f.last_modified
          end
        end
        page.response_time =  (sw.end * 1000).floor
      end
    rescue => e
      dl(link, remain_times - 1)
      Util.log "Error in dl|#{link.url}|RETRYING#{remain_times - 1}|#{e}"
    end
    page
  end

  def get_a_job
    item = @queue.pop
    puts item.class
    puts  item[:payload].class
    if item[:payload].is_a? String
      link = YAML::load item[:payload]
    else
      link = nil
    end
    link
  end



end

lw=Linkworker.new "localhost"
lw.run

