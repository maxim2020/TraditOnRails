class TradeController < ApplicationController
  
  #main trade page
  def index
    @currencies = current_user.nested_currencies.all
    
    respond_to do |format|
      format.html #"index"
      format.json {render json: @currencies} #send user currencies info, in .json format
    end
    
  end
  
  #post a trade
  def create
    print RubyVM::InstructionSequence.disasm(method(:create))
      #get params from the ajax post
      currencyF_name = params[:currencyF]
      currencyT_name = params[:currencyT]
      quantityF = params[:quantity].to_i
      
      #take the "from" and the "to" rate
      ratesF = Currency.find_by(name: currencyF_name).rates.all
      ratesT = Currency.find_by(name: currencyT_name).rates.all
      
      #get the "to" quantity
      quantityT = (ratesF[0].value * quantityF) / ratesT[0].value
      quantityT = quantityT.round
     
      #update the "from" and "to" quantity
      user = current_user
      @currencies = user.nested_currencies.all
      @currencies.each do |currency|
        if currency.name == currencyF_name
           currency.update_attributes(number: currency.number - quantityF)
        end
        if currency.name == currencyT_name
          currency.update_attributes(number: currency.number + quantityT)
        end
        #save user into the db
        currency.save()
      end

    #create a transaction
    transaction = Transaction.new(
      action: "SELL",
      amount_from: quantityF,
      amount_to: quantityT,
      email: user.email,
      date: DateTime.now,
      currency_from: currencyF_name,
      currency_to: currencyT_name,
      user: user.id,
      rate_from: ratesF[0].value,
      rate_to: ratesT[0].value
    )
    #save transaction into the db
    transaction.save()
    #send back the trade partial page
    render :partial => 'trade'
  end

end
