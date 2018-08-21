module Viewer
  
  def product_status(product_name, product_count)
    puts "You currently have #{product_name } #{product_count}."
  end
  
  def sale(sold_product)
    puts "You sold a banana split! you now have #{sold_product} banana splits remaining and have #{self.money.round(2)} money."
  end

  def welcome
    puts "Welcome to the Banana Stand! You have started with $#{@inventory.money}. Please input how much you want Banana Splits to cost today:"
  end

  def supplies_message
    puts "Please select from:"
    puts "1. Banana | 2. Icecream"
    puts "What would you like to buy?"
  end

  def buy_supplies_message
    puts "How much would you like to purchase?"
  end

  def input_unclear
    puts "I'm sorry, I did not understand that. Please try again."
  end

  def bank_balance
    puts "You have $#{self.money.round(2)} dollars remaining."
  end
  def insufficient_credit
    puts "You do not have enough money to afford this."
  end
  def not_enough_product
    puts "You don't have enough products to fulfill this request."
  end

  def production_message
    puts "How many Banana Splits would you like to make?"
  end

  def market_price_message
    puts "The price for bananas today is $#{self.banana_price}"
    puts "The price for icecream today is $#{self.icecream_price}"
    puts "You will need to charge at least $#{self.break_even_price.round(2)} to break even today."
  end

  def product_price_message
    puts "How much would you like to sell Banana Splits for today?"
  end

  def user_options
    puts "------------------------------------------------------------------------"
    puts "What would you like to do today?"
    puts " 1. Buy || 2. Produce || 3. Price Set "
    puts "More information can be obtained by asking for:"
    puts "4. Climate || 5. Market Costs || 6. Current Balance || 7. Yesterdays performance"
    puts "Or if you are ready to begin the day, select 'Start'"
    puts "------------------------------------------------------------------------"
  end
end