class Currency
  include Mongoid::Document
  
  #schema
  field :is_reference, type: Boolean
  field :name
  
  embeds_many :rates, store_as: "rate"#, :class_name => "Rates", :inverse_of => :currency, :autobuild => true
  accepts_nested_attributes_for :rates
  
  embeds_many :nested_currencies, store_as: "currencies"
  accepts_nested_attributes_for :nested_currencies
  
  #validation
  validates_presence_of :name
  validates_presence_of :is_reference
  validates_uniqueness_of :name
  
end
