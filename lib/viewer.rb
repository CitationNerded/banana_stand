class Viewer
  
  def product_status(product_name, product_count)
    puts "You currently have #{product_count } #{product_name}."
  end
  
  
  def welcome(money)
    puts "Welcome to the Banana Stand! You have started with $#{money}. Please input how much you want Banana Splits to cost today:"
  end
  
  def supplies_message
    puts "Please select from:"
    puts "1. Banana | 2. Icecream "
    puts "What would you like to buy?"
  end
  
  def buy_supplies_message
    puts "How much would you like to purchase?"
  end
  
  def input_unclear
    puts "I'm sorry, I did not understand that. Please try again."
  end

  def insufficient_product_price
    puts "The sale price of your products must be greater than 0."
  end
  
  def bank_balance(money)
    puts "You have $#{money} dollars remaining."
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
  
  def market_price_message(banana_price, icecream_price, break_even_price)
    puts "The price for bananas today is $#{banana_price}"
    puts "The price for icecream today is $#{icecream_price}"
    puts "You will need to charge at least $#{break_even_price} to break even today."
  end
  
  def product_price_message
    puts "How much would you like to sell Banana Splits for today?"
  end
  
  def user_options #maybe use a heredoc
    puts "------------------------------------------------------------------------"
    puts "What would you like to do today?"
    puts " 1. Buy || 2. Produce || 3. Price Set "
    puts "More information can be obtained by asking for:"
    puts "4. Climate || 5. Market Costs || 6. Current Balance || 7. Yesterdays performance || 8. Estimated Foot Traffic"
    puts "Or if you are ready to begin the day, select '0. Start'"
    puts "------------------------------------------------------------------------"
  end
    
  def weather_report(weather)
    puts "Today the weather is looking like #{weather} degrees."
  end
  
  def walker_report(foot_traffic)
    puts "Today we estimate around #{foot_traffic} walkers will come by the Banana Stand."
  end
  
  def sales_message(actual_buyers, potential_buyers, wastage)
    puts("You have sold to #{actual_buyers} buyers today! You missed selling to #{potential_buyers} Potential Buyers.")
    puts("You wasted #{wastage} banana splits")
  end
  
  def end_of_day_report(money,net_profit)
    puts "Congratulations! you now have $#{money}. This is a profit of $#{net_profit}"
  end

  def you_have_failed
    puts "Unfortunately you have run out of money and have had to shutdown."
    puts "It turns out, there is not always money in the banana stand"
  end
end