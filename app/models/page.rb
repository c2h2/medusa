class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  field :worker, :type => String
  field :code, :type => Integer
  field :fn, :type => String
  field :charset, :type => String
  field :title, :type => String
  field :mime, :type => String
  field :etag, :type => String
  field :resp_ms, :type => Integer
  field :length, :type => Integer
  field :state, :type => Integer
  field :hash, :type => String
  field :lm_at, :type => DateTime
  field :exp_at, :type => DateTime


  def dl url, ua=nil, cookie=nil, params={}
    remain_times = params[:remain]
    
    if remain_times<=0
      self.code = 1999
    end
  end
end
