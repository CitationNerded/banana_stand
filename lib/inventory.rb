class Inventory
  attr_accessor :sellable_product #this is needed for the day class to reset it to 0 at the end of each day
  attr_reader :money, :actual_buyers, :potential_buyers, :stock_to_buy, :insufficient_credit, :stock
  def initialize
    @money = 5
    @sellable_product = {"Banana Split" => 0}
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

  def make_product(product_to_make, quantity = 1)
    while  ((quantity > @sellable_product.values[0]) && @stock.all?{|key, value| value > 0 })
      recipe_book(product_to_make)
    end
  end
  
  def sell_product(sale_price,potential_buyers)
    @actual_buyers = 0
    @potential_buyers = potential_buyers
    while (0 < @potential_buyers) && (@sellable_product.values[0] > 0)
      @sellable_product[@sellable_product.keys[0]] -= 1
      @potential_buyers -= 1
      @actual_buyers += 1
      @money += sale_price
    end
  end

  private
  
  def cannot_afford?
    @money < 0.0
  end

  def recipe_book(product_to_make)
    if product_to_make == "Banana Split"
      @stock[@stock.keys[0]] -= 1 #One Banana
      @stock[@stock.keys[1]] -= 1 #One Icecream
      @sellable_product[@sellable_product.keys[0]] += 1 #Makes One Banana Split
    end
  end
end