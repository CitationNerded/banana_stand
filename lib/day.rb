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

  def get_input(valid_selection = 1000)
    loop do
      input = gets.chomp
      return input.to_i if ((input.to_i.to_s == input) && input.to_i <= valid_selection.to_i)
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

  def buy_stock_menu
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
      buy_stock_menu
    end
  end
  
  def day_events
    potential_buyers = @market.market_interest(@foot_traffic, @@days_survived)
    @inventory.sell_product(@market.price_of_split ,potential_buyers)
    @viewer.sales_message(@inventory.actual_buyers, @inventory.potential_buyers, @inventory.sellable_product.keys[0])
    
    net_profit = (@inventory.money - starting_balance).round(2)
    @viewer.end_of_day_report(@inventory.money, net_profit)
    
    @inventory.sellable_product[@inventory.sellable_product.keys[0]] = 0
    loss_condition? ? @viewer.you_have_failed : @viewer.you_have_survived(@@days_survived)
  end
  
  def options
    @viewer.user_options    
    selected_option = get_input(7)
    case
    when selected_option == 0
      day_events
    when selected_option == 1
      buy_stock_menu
      options
    when selected_option == 2
      make_product_menu
      options
    when selected_option == 3
      @viewer.product_price_message
      @market.split_price(get_input)
      options
    when selected_option == 4
      @viewer.weather_report(@climate.weather)
      options
    when selected_option == 5
      @viewer.market_price_message(@market.banana_price,@market.icecream_price,@market.break_even_price)
      options
    when selected_option == 6
      @viewer.bank_balance(@inventory.money.round(2))
      options
    when selected_option == 7
      @viewer.walker_report(@foot_traffic)
      options
    else
      options
    end
  end
  
  private
  def stock_selection
    @viewer.supplies_message
    @stock = get_input(@inventory.stock.size)
    @stock_to_buy = @inventory.stock.keys[@stock-1]

    @viewer.buy_supplies_message
    @stock_quantity = get_input
  end
  
  def make_product_menu #Might be worth renaming this to not be confused with the inventory class version of this method
    @viewer.product_select_message
    product_input = get_input(@inventory.sellable_product.length)
    product = @inventory.sellable_product.keys[product_input -1]
    @viewer.product_quantity_message(product)
    quantity = get_input

    @inventory.make_product(product, quantity)
    @inventory.stock.each{ |value,key| @viewer.product_status(key, value)}
    @viewer.product_status(@inventory.sellable_product.values[0], @inventory.sellable_product.keys[0])
  end
  
  def loss_condition?
    ((@inventory.money < @market.banana_price) && (@inventory.stock.values[0] == 0)) || ((@inventory.money < @market.icecream_price) && (@inventory.stock.values[0] == 0))
  end
end