class Day
  attr_reader :starting_balance, :stock_to_buy, :stock_price, :stock, :stock_quantity
  @@days_survived = 0

  def initialize(inventory, climate, foot_traffic, market, viewer)      
    @@days_survived += 1
    @inventory = inventory
    @climate = climate
    @foot_traffic = foot_traffic
    @market = market
    @viewer = viewer
    start_of_day
  end

  def get_input
    loop do
      input = gets.chomp
      return input.to_i if (input.to_i.to_s == input)
      @viewer.input_unclear
    end
  end
  
  def start_of_day
    @starting_balance = @inventory.money
    @market.market_conditions

    @viewer.market_price_message(@market.banana_price,@market.icecream_price,@market.break_even_price)
    @market.split_price(get_input)
    options
  end
  def stock_menu
  stock_selection
    if stock <= @inventory.stock.keys.count
      stock_price_join = stock_to_buy + "_price"
      stock_price = @market.send(stock_price_join)

      @inventory.buy_stock(stock_to_buy, stock_price, @stock_quantity)

      if @inventory.insufficient_credit
        @viewer.insufficient_credit
      else
        @viewer.product_status(@inventory.stock[stock_to_buy], stock_to_buy)
        @viewer.bank_balance(@inventory.money.round(2))
      end
    else
      @viewer.input_unclear
      stock_menu
    end
  end
  
  def day_events
    potential_buyers = @market.market_interest(@foot_traffic, @@days_survived)
    @inventory.sell_product(@market.price_of_split ,potential_buyers)
    @viewer.sales_message(@inventory.actual_buyers, @inventory.potential_buyers, @inventory.banana_splits)
    
    net_profit = (@inventory.money - starting_balance).round(2)
    @viewer.end_of_day_report(@inventory.money, net_profit)
    
    @inventory.banana_splits = 0
    loss_condition? ? @viewer.you_have_failed : @viewer.you_have_survived(@@days_survived)
  end
  
  def options
    @viewer.user_options    
    selected_option = get_input.to_s
    case
    when ("0. Start").include?(selected_option)
      day_events
    when ("1. Buy").include?(selected_option)
      stock_menu
      options
    when ("2. Produce").include?(selected_option)
      @viewer.production_message
      make_product
      options
    when ("3. Price Set").include?(selected_option)
      @viewer.product_price_message
      @market.split_price(get_input)
      options
    when ("4. Climate").include?(selected_option)
      @viewer.weather_report(@climate.weather)
      options
    when ("5. Market Costs").include?(selected_option)
      @viewer.market_price_message(@market.banana_price,@market.icecream_price,@market.break_even_price)
      options
    when ("6. Current Balance").include?(selected_option)
      @viewer.bank_balance(@inventory.money.round(2))
      options
    when ("7. Estimated Foot Traffic").include?(selected_option)
      @viewer.walker_report(@foot_traffic)
      options
    else
      options
    end
  end
  
  private
  def stock_selection
    @viewer.supplies_message
    @stock = get_input
    @stock_to_buy = @inventory.stock.keys[@stock-1]

    @viewer.buy_supplies_message
    @stock_quantity = get_input.to_i
  end
  
  def make_product #Might be worth renaming this to not be confused with the inventory class version of this method
    @inventory.make_product(get_input)
    @inventory.stock.each{ |value,key| @viewer.product_status(key, value)}
    @viewer.product_status(@inventory.banana_splits, "Banana Splits")
  end
  
  def loss_condition?
    ((@inventory.money < @market.banana_price) && (@inventory.stock["banana"] == 0)) || ((@inventory.money < @market.icecream_price) && (@inventory.stock["icecream"] == 0))
  end
end