class Transaction
  include Mongoid::Document
  
  #schema
  field :action, type: String
  field :amount_from, type: Integer
  field :amount_to, type: Integer
  field :email, type: String
  field :date, type: DateTime
  field :currency_from, type: String
  field :currency_to, type: String
  field :user, type: String
  field :rate_from, type: Float
  field :rate_to, type: Float
  
  #validation
  validates_presence_of :email
  
end
