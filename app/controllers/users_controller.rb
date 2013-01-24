class UsersController < ApplicationController
  
  #new account page
  def new
    @refcurrencies = Currency.all
    @user = User.new
    @user.nested_currencies.build
  end
  
  #create account page
  def create
    @user = User.new(params[:user])
    if @user.save
      params[:user][:nested_currencies_attributes].values.each do |currency|
        @user.nested_currencies << NestedCurrency.new(number: currency["number"] ,name: currency["name"])
      end
      user_saved = User.authenticate(@user.email, @user.password)
      if user_saved
        session[:user_id] = user_saved.id
        redirect_to root_url, :notice => "registered and logged in !"
      end
    else
      redirect_to register_url, :notice => "Error - input email and password"
    end
  end
  
  #account main page
  def index
    @user = current_user
    @transactions = Transaction.where(email: current_user.email)
    render "index"
  end
  
end