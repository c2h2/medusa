class Link
  include Mongoid::Document
  include Mongoid::Timestamps
  field :url, :type => String
  field :rank, :type => Float
  field :lv_at, :type => DateTime
  field :state, :type => Integer
  field :depth, :type => Integer



end
