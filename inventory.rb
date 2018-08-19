class Inventory
  attr_accessor :split_price #Read and write functionality
  attr_reader :money, :banana, :icecream_scoop, :banana_splits #can only be read
#abstract out all view logic from the inventory class. Also add validations (before_save or ruby equivalent for this to prevent negative values of stock)
  def initialize(banana_split_price, starting_money)
    @money = starting_money
    #-----------------------------
    @banana, @icecream_scoop, @banana_splits = 0, 0, 0
    #@banana_cost, @icecream_cost = 0.25, 0.5
    #-----------------------------
    @banana_splits = 0
    @split_price = banana_split_price
  end
  
  def buy_icecream(quantity = 1)
    @money -= @icecream_price
    @icecream_scoop += quantity
    puts "you now have #{@icecream_scoop} icecream scoops"
  end

  def buy_banana(quantity = 1)
    @money -= @banana_price
    @banana += quantity
    puts "you now have #{@banana} bananas"
  end

  def make_split(quantity = 1)
    @banana_splits += quantity
    @banana -= quantity
    @icecream_scoop -= quantity
    puts "you now have #{@banana_splits} banana splits"
  end

  def sell_split(quantity = 1)
    @banana_splits -= quantity
    @money += @split_price
    puts "You sold a banana split! you now have #{@banana_splits} banana splits remaining and have #{@money} money."
  end
end