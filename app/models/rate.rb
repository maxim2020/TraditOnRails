class Rate
  include Mongoid::Document
  
  #schema
  field :date, type: DateTime
  field :value, type: Float
  
  embedded_in :currency, :inverse_of => :rates

  #validation
  validates_presence_of :value, :on => :create
  validates_presence_of :date, :on => :create
  
end
