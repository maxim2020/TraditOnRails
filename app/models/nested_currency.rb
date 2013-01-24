class NestedCurrency
  include Mongoid::Document
  
  #schema
  field :name
  field :number, type: Integer
  
  embedded_in :user, :inverse_of => :nested_currencies
  
  #validation
  validates_presence_of :name, :on => :create
  validates_presence_of :number, :on => :create
  validates_uniqueness_of :name
end
