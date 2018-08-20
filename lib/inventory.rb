class Inventory
  attr_accessor :split_price #Read and write functionality
  attr_reader :money, :banana, :icecream_scoop, :banana_splits #can only be read
#abstract out all view logic from the inventory class. Also add validations (before_save or ruby equivalent for this to prevent negative values of stock)
  def initialize(banana_split_price, starting_money)
    @money = starting_money
    #-----------------------------
    @banana, @icecream_scoop, @banana_splits = 0, 0, 0
    @banana_cost, @icecream_cost = 0.25, 0.5
    #-----------------------------
    @banana_splits = 0
    @split_price = banana_split_price
  end
  
  def buy_icecream(quantity = 1)
    before_purchase = @money
    after_purchase = @money -= @icecream_cost * quantity

    bankrupt? ? @money = before_purchase : @icecream_scoop += quantity
    #puts "you now have #{@icecream_scoop} icecream scoops"
  end

  def buy_banana(quantity = 1)
    before_purchase = @money
    after_purchase = @money -= @banana_cost * quantity

    bankrupt? ? @money = before_purchase : @banana += quantity

    #puts "you now have #{@banana} bananas"
  end

  def make_split(quantity = 1)
    if quantity > (@banana || @icecream_scoop)
      return
    else
      @banana -= quantity
      @icecream_scoop -= quantity
      @banana_splits += quantity
    end
    #puts "you now have #{@banana_splits} banana splits"
  end

  def sell_split(quantity = 1)
    @banana_splits -= quantity
    @money += @split_price
    #puts "You sold a banana split! you now have #{@banana_splits} banana splits remaining and have #{@money} money."
  end
  
  private

  # def can_afford(quantity, product)
  #   (products * cost) <= @money
  # end

  def bankrupt?
    @money <= 0.0
  end

  def out_of_product?
    (@banana || @icecream_scoop) <= 0
  end
end