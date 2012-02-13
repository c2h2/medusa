class Rule
  include Mongoid::Document
  field :domain, :type => String
  field :detail, :type => String
  field :allow, :type => Boolean
end
