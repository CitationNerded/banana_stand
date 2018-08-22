require_relative './viewer'

class Inventory
  include Viewer
  attr_accessor :banana_splits #Read and write functionality
  attr_reader :money, :banana, :icecream_scoop, :actual_buyers, :potential_buyers #can only be read
  #abstract out all view logic from the inventory class. Also add validations (before_save or ruby equivalent for this to prevent negative values of stock)
  
  def initialize
    @money = 5
    @banana, @icecream_scoop, @banana_splits = 0, 0, 0
  end

  def buy_stock(stock_to_buy, cost_of_stock, quantity = 1)
    before_purchase = @money

    if stock_to_buy == "banana"
      after_purchase = @money -= cost_of_stock * quantity
      cannot_afford? ? (@money = before_purchase) && insufficient_credit : @banana += quantity
      product_status(stock_to_buy, @banana)
    elsif stock_to_buy == "icecream"
      after_purchase = @money -= cost_of_stock * quantity
      cannot_afford? ? (@money = before_purchase) && insufficient_credit : @icecream_scoop += quantity
      product_status(stock_to_buy, @icecream_scoop)
    end
  end

  def make_product(quantity)
    if 0 == (@banana || @icecream_scoop)
      not_enough_product
    else
      while  (quantity > @banana_splits) && ((@banana && @icecream_scoop) > 0)
        @banana -= 1
        @icecream_scoop -= 1
        @banana_splits += 1
      end
    end
    
    product_status(@banana, "Banana")
    product_status(@icecream_scoop, "Icecream Scoops")
    product_status(@banana_splits, "Banana Splits")
  end
  
  def sell_product(sale_price,potential_buyers)
    actual_buyers = 0
    while (0 < potential_buyers) && (@banana_splits > 0)
      @banana_splits -= 1
      potential_buyers -= 1
      actual_buyers += 1
      @money += sale_price
    end
    sales_message(actual_buyers, potential_buyers)
  end

  private
  
  def cannot_afford?
    money < 0.0
  end
  
  def out_of_product?
    (banana || icecream_scoop) <= 0
  end
end