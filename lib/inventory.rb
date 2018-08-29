class Inventory
  attr_reader :sellable_product, :stock_to_buy, :insufficient_credit, :stock
  attr_accessor :actual_buyers, :money, :potential_buyers
  def initialize
    @money = 5
    @sellable_product = {"Banana Split" => 0}
    @stock = {"banana" => 0, "icecream" => 0 }
  end

  def buy_stock(stock_to_buy, cost_of_stock, stock_quantity = 1)
    before_purchase = self.money
    self.money -= (cost_of_stock * stock_quantity)

    if cannot_afford?
      self.money = before_purchase
      insufficient_credit = true
    else
      insufficient_credit = false
      self.stock[stock_to_buy] += stock_quantity
    end
    self.money.round(2)
  end

  def make_product(product_to_make, quantity = 1)
    while  ((quantity > self.sellable_product.values[0]) && self.stock.all?{|key, value| value > 0 })
      recipe_book(product_to_make)
    end
  end
  
  def sell_product(sale_price,potential_buyers)
    self.actual_buyers = 0
    self.potential_buyers = potential_buyers
    while (0 < self.potential_buyers) && (self.sellable_product.values[0] > 0)
      self.sellable_product[self.sellable_product.keys[0]] -= 1
      self.potential_buyers -= 1
      self.actual_buyers += 1
      self.money += sale_price
      self.money.round(2)
    end
  end

  private
  
  def cannot_afford?
    self.money < 0.0
  end

  def recipe_book(product_to_make)
    if product_to_make == "Banana Split"
      self.stock[self.stock.keys[0]] -= 1 #One Banana
      self.stock[self.stock.keys[1]] -= 1 #One Icecream
      self.sellable_product[self.sellable_product.keys[0]] += 1 #Makes One Banana Split
    end
  end
end