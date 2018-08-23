class Inventory
  attr_accessor :banana_splits #this is needed for the day class to reset it to 0 at the end of each day
  attr_reader :money, :actual_buyers, :potential_buyers, :stock_to_buy, :insufficient_credit, :stock
  def initialize
    @money = 5
    @banana_splits = 0
    @stock = {"banana" => 0, "icecream" => 0 }
  end

  def buy_stock(stock_to_buy, cost_of_stock, stock_quantity = 1)
    before_purchase = @money
    @money -= (cost_of_stock * stock_quantity)
    if cannot_afford?
      @money = before_purchase
      insufficient_credit = false
    else
      insufficient_credit = true
      @stock[stock_to_buy] += stock_quantity
    end
  end

  def make_product(quantity)
    while  ((quantity > @banana_splits) && @stock.all?{|key, value| value > 0 })
      @stock["banana"] -= 1
      @stock["icecream"] -= 1
      @banana_splits += 1
    end
  end
  
  def sell_product(sale_price,potential_buyers)
    @actual_buyers = 0
    @potential_buyers = potential_buyers
    while (0 < potential_buyers) && (banana_splits > 0)
      @banana_splits -= 1
      @potential_buyers -= 1
      @actual_buyers += 1
      @money += sale_price
    end
  end

  private
  
  def cannot_afford?
    @money < 0.0
  end
end