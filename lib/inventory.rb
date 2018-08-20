require_relative './market'
require_relative './viewer'

class Inventory
  include Viewer
  attr_accessor :split_price, :buy_banana, :market #Read and write functionality
  attr_reader :money, :banana, :icecream_scoop, :banana_splits #can only be read
  #abstract out all view logic from the inventory class. Also add validations (before_save or ruby equivalent for this to prevent negative values of stock)
  
  def initialize(price_of_split)
    @money = 5
    @banana, @icecream_scoop, @banana_splits = 0, 0, 0

    @banana_splits = 0
    @split_price = price_of_split

    #@banana_price, @icecream_price = 0.25, 0.5 #these are stubbed values that need to be being inherited from the market class


    #----------------- I am unhappy with needing to initialize this here rather than in the game class.
    #@market = Market.new
    #@market.market_conditions
    #-----------------

  end

  def buy_product(quantity, product)
    before_purchase = @money

    if product == "banana"
      product_price = @market.banana_price
      after_purchase = @money -= product_price * quantity
      bankrupt? ? (@money = before_purchase) && insufficient_credit : @banana += quantity
      product_status(@banana, product)

    elsif product == "icecream"
      product_price = @market.icecream_price
      after_purchase = @money -= product_price * quantity
      bankrupt? ? (@money = before_purchase) && insufficient_credit : @icecream_scoop += quantity
      product_status(@icecream_scoop, product)

    end
    bank_balance
  end

  def make_split(quantity)
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
    @money += @split_price

    sale(@banana_splits)
  end
  
  private
  
  def bankrupt?
    money <= 0.0
  end
  
  def out_of_product?
    (banana || icecream_scoop) <= 0
  end
end