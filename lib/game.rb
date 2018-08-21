require_relative './market'
require_relative './inventory'
require_relative './climate'
require_relative './foot_traffic'

class Game
  include Viewer
  attr_accessor :market, :inventory, :viewer, :get_input
  def initialize
    @inventory = Inventory.new #belongs in game class
    @market = Market.new #belongs in day class
    @market.market_conditions #belongs in day class
    @climate= Climate.new #belongs in the game class
    @climate.progress_weather_patterns # belongs in day class
    
    @foot_traffic = FootTraffic.new #belongs in the game class
    @foot_traffic.walker_forecast(@climate.weather) #belongs in the day class
    welcome
    start_of_day
  end
    
  def get_input
    input = gets.chomp
    if (input.to_i.to_s == input)
      input.to_i
    else
      input
    end
  end
  
  def start_of_day
    @market.market_prices
    @market.split_price(get_input)
    options
  end
  
  def stock_menu
    supplies_message
    stock = get_input.to_s
    buy_supplies_message
    stock_quantity = get_input.to_i
    case
    when ("1. Banana").include?(stock)
      @inventory.buy_stock("banana", @market.banana_price, stock_quantity)
    when ("2. Icecream").include?(stock)
      @inventory.buy_stock("icecream", @market.icecream_price, stock_quantity)
    else 
      stock_menu
    end
  end

  def options
    user_options    
    selected_option = get_input.to_s
    case
    when ("0. Start").include?(selected_option)
      @day.begin
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
      @market.market_prices
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
      input_unclear
      options
    end
  end
end


my_game = Game.new