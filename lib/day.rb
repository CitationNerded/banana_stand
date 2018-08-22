#At the beginning of the day in this order:

#The climate is inialized. This helps to determine the market conditions and is passed into the market. 
#The climate relies on the previous days climate. protected method comparison?
#The market is inialized. this sets the market conditions for the day for shopping.
#The number of people that will walk by the banana stand is calculated from the climate.

#The user is prompted for input on how many bananas and icecream scoops they wish to buy.
#The user is prompted on how many banana splits they wish to make.
#The user is prompted on how much they want banana splits to cost for the day

#The number of people  that will buy from the banana stand is now calculated
require_relative './market'
require_relative './inventory'
require_relative './foot_traffic'
require_relative './climate'

class Day
  include Viewer
  attr_reader :starting_balance
  @@days_survived = -1

  def initialize(inventory, climate)
    @@days_survived += 1
    construct_game_parameters(inventory,climate)
    start_of_day
  end

  def get_input
    input_clarity = false
    while input_clarity == false
      input = gets.chomp
      if (input.to_i.to_s == input)
        input_clarity = true
        return_input = input.to_i
      else
        input_unclear
      end
    end
    return_input
  end
  
  def start_of_day
    @starting_balance = @inventory.money
    market_price_message
    @market.split_price(get_input)
    puts @market.price_of_split
    options
  end
  
  def stock_menu
    supplies_message
    stock = get_input.to_s
    buy_supplies_message
    stock_quantity = get_input.to_i
    case
    when ("1. Banana").include?(stock) #enumerables
      @inventory.buy_stock("banana", @market.banana_price, stock_quantity)
    when ("2. Icecream").include?(stock)
      @inventory.buy_stock("icecream", @market.icecream_price, stock_quantity)
    else 
      stock_menu #not sure this sort of call should be made within its own method... maybe self would do the same thing?
    end
    bank_balance
  end
  
  def day_events
    potential_buyers = @market.market_interest(@foot_traffic.walkers)
    @inventory.sell_product(@market.price_of_split ,potential_buyers)
    
    net_profit = (@inventory.money - starting_balance).round(2)
    end_of_day_report(net_profit)
    
    @inventory.banana_splits = 0
    you_have_failed if loss_condition?
  end
  
  def options
    user_options    
    selected_option = get_input.to_s
    case
    when ("0. Start").include?(selected_option)
      day_events
    when ("1. Buy").include?(selected_option)
      stock_menu
      options
    when ("2. Produce").include?(selected_option)
      production_message
      @inventory.make_product(get_input)
      options
    when ("3. Price Set").include?(selected_option)
      product_price_message
      @market.split_price(get_input)
      options
    when ("4. Climate").include?(selected_option)
      weather_report
      options
    when ("5. Market Costs").include?(selected_option)
      market_price_message
      options
    when ("6. Current Balance").include?(selected_option)
      @inventory.bank_balance
      options
    when ("7. Yesterdays Performance").include?(selected_option)
      options
    when ("8. Estimated Foot Traffic").include?(selected_option)
      walker_report
      options
    else
      options
    end
  end
  
  private
  def construct_game_parameters(inventory,climate)
    @inventory = inventory
    @weather = climate
    
    initialize_market
    intialize_foot_traffic
  end

  def initialize_market
    @market = Market.new
    @market.market_conditions
  end

  def intialize_foot_traffic
    @foot_traffic = FootTraffic.new
    @foot_traffic.walker_forecast(@weather)
  end

  def loss_condition?
    ((@inventory.money < @market.banana_price) && (@inventory.banana == 0)) || ((@inventory.money < @market.icecream_price) && (@inventory.icecream_scoop == 0))
  end
end