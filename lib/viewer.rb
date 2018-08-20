module Viewer
  
  def product_status(product_name, product_count)
    puts "You currently have #{product_name } #{product_count}."
  end
  
  def sale(sold_product)
    puts "You sold a banana split! you now have #{sold_product} banana splits remaining and have #{@money} money."
  end

  def welcome
    puts "Welcome to the Banana Stand! You have started with #{@money}. Please input how much you want Banana Splits to cost today:"
  end

  def supplies_prompt
    puts "What supplies would you like to buy? "
  end

  def buy_supplies(type_of_goods)
    puts "How much of #{type_of_goods} would you like to purchase?"
  end

  def input_unclear
    puts "I'm sorry, I did not understand that. Please try again."
  end

  def bank_balance
    puts "You have #{@money} dollars remaining."
  end
  def insufficient_credit
    puts "You do not have enough money to afford this."
  end
  def not_enough_product
    puts "You don't have enough products to fulfill this request."
  end

  def production_prompt
    puts "How many Banana Splits would you like to make?"
  end

  def market_price_message
    puts "The price for bananas today is $#{@market.banana_price}"
    puts "The price for icecream today is $#{@market.icecream_price}"
  end
end