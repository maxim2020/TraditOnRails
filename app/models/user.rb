class User
  include Mongoid::Document
  
  #schema
  field :firstname
  field :lastname
  field :email
  field :hashed_pwd
  field :salt

  embeds_many :nested_currencies, store_as: "currencies"
  accepts_nested_attributes_for :nested_currencies
  
  #attributes
  attr_accessible :email, :password, :password_confirmation, :firstname, :lastname
  attr_accessor :password, :password_confirmation
  
  #validation
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  #authentication method
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user && user.hashed_pwd == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  #generate a salt and a hash
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.hashed_pwd = BCrypt::Engine.hash_secret(password, salt)
    end
  end

end
