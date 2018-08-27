class Viewer
  
  def product_status(product_count, product_name)
    puts "You currently have #{product_count} #{product_name}."
  end
  
  
  def welcome(money)
    puts "Welcome to the Banana Stand! You have started with $#{money}."
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
    puts "I'm sorry, I did not understand that. Are you sure that was a valid option?."
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
  
  def product_select_message
    puts "What product do you wish to make?"
    puts "1. Banana Split" 
  end

  def product_quantity_message(product)
    puts "How many #{product} would you like to make?"
  end
  
  def market_price_message(banana_price, icecream_price, break_even_price)
    puts "The price for bananas today is $#{banana_price}"
    puts "The price for icecream today is $#{icecream_price}"
    puts "You will need to charge at least $#{break_even_price} to break even today."
    puts
    puts "What would you like to charge?"
  end
  
  def product_price_message
    puts "How much would you like to sell Banana Splits for today?"
  end
  
  def user_options #Ran into difficulties using HEREDOCs here but would like to try and implement this.
    puts <<~HEREDOC
      ------------------------------------------------------------------------
      What would you like to do today?
      1. Buy || 2. Produce || 3. Price Set
      More information can be obtained by asking for:
      4. Climate || 5. Market Costs || 6. Current Balance || 7. Estimated Foot Traffic
      Or if you are ready to begin the day, select '0. Start'
      ------------------------------------------------------------------------
    HEREDOC
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
  
  def you_have_survived(number_of_days)
    puts "So far you have survived for #{number_of_days} days."
  end

  def you_have_failed
    puts "Unfortunately you have run out of money and have had to shutdown."
    puts "It turns out, there is not always money in the banana stand"
  end
end