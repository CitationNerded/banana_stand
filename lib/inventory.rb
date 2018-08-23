class Inventory
  attr_accessor :banana_splits #this is needed for the day class to reset it to 0 at the end of each day
  attr_reader :money, :banana, :icecream_scoop, :actual_buyers, :potential_buyers
  def initialize
    @money = 5
    @banana, @icecream_scoop, @banana_splits = 0, 0, 0
  end

  def buy_stock(stock_to_buy, cost_of_stock, quantity = 1)
    before_purchase = money

    if stock_to_buy == "banana"
      @money -= (cost_of_stock * quantity)
      cannot_afford? ? (money = before_purchase) && insufficient_credit : @banana += quantity #currently broken because insufficient_credit will rely on the viewer class
    elsif stock_to_buy == "icecream"
      @money -= (cost_of_stock * quantity)
      cannot_afford? ? (money = before_purchase) && insufficient_credit : @icecream_scoop += quantity
    end
  end

  def make_product(quantity)
    while  (quantity > banana_splits) && ((banana && icecream_scoop) > 0)
      banana -= 1
      icecream_scoop -= 1
      banana_splits += 1
    end
  end
  
  def sell_product(sale_price,potential_buyers)
    @actual_buyers = 0
    @potential_buyers = potential_buyers
    while (0 < potential_buyers) && (banana_splits > 0)
      banana_splits -= 1
      potential_buyers -= 1
      actual_buyers += 1
      money += sale_price
    end
  end

  private
  
  def cannot_afford?
    money < 0.0
  end
  
  def out_of_product?
    (banana || icecream_scoop) <= 0
  end
end