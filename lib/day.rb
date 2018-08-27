class Day
  attr_accessor :inventory, :climate, :foot_traffic, :market, :viewer, :input, :options
  
  attr_reader :starting_balance, :stock_to_buy, :stock_price, :stock, :stock_quantity, :product, :net_profit, :days_survived, :potential_buyers
  @@days_survived = 0

  def initialize(inventory, climate, foot_traffic, market, input)      
    @@days_survived += 1
    @inventory = inventory
    @climate = climate
    @foot_traffic = foot_traffic
    @market = market
    @input = input
    
    initialize_day
  end
  
  def initialize_day
    @starting_balance = @inventory.money
    @market.market_conditions
  end

  def set_product_price(input)
    @market.split_price(input)
  end

  
  def establish_buyers
    @potential_buyers = @market.market_interest(@foot_traffic, @@days_survived)
  end
  
  def sell_product
    @inventory.sell_product(@market.price_of_split ,@potential_buyers)
  end

  def establish_profit
    @net_profit = (@inventory.money - starting_balance).round(2)
  end
  
  def destroy_product_surplus
    @inventory.sellable_product[@inventory.sellable_product.keys[0]] = 0
  end
  
  def stock_to_purchase(input)
    @stock = input
    @stock_to_buy = @inventory.stock.keys[@stock-1]
  end
  
  def quantity_to_purchase(input)
    @stock_quantity = input
  end
  
  def purchase_stock
    if stock <= @inventory.stock.keys.count
      stock_price_join = @stock_to_buy + "_price"
      stock_price = @market.send(stock_price_join)
      @inventory.buy_stock(@stock_to_buy, stock_price, @stock_quantity)
    end
  end
  
  def product_to_make(input)
    product_input = input
    @product = @inventory.sellable_product.keys[product_input -1]
  end
  
  def quantity_to_make(input)
    @product_quantity = input
  end
  
  def make_product
    @inventory.make_product(@product, @product_quantity)
  end

  def loss_condition?
    ((@inventory.money < @market.banana_price) && (@inventory.stock.values[0] == 0)) || ((@inventory.money < @market.icecream_price) && (@inventory.stock.values[0] == 0))
  end
end