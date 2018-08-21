require_relative './market'
require_relative './viewer'

class Inventory
  include Viewer
  #attr_accessor :split_price, :buy_banana, :market #Read and write functionality
  attr_reader :money, :banana, :icecream_scoop, :banana_splits #can only be read
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
    bank_balance
  end

  def make_product(quantity)
    if quantity > (@banana && @icecream_scoop)
      not_enough_product
    else
      @banana -= quantity
      @icecream_scoop -= quantity
      @banana_splits += quantity
    end

    product_status(@banana, "Banana")
    product_status(@icecream_scoop, "Icecream Scoops")
    product_status(@banana_splits, "Banana Splits")
  end

  def sell_split(quantity = 1) #selling banana splits probably does not belong in the inventory class.
    @banana_splits -= quantity
    @money += @market.split_price

    sale(@banana_splits)
  end

  private
  
  def cannot_afford?
    money <= 0.0
  end
  
  def out_of_product?
    (banana || icecream_scoop) <= 0
  end
end