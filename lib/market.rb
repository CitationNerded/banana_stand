class Market
  attr_reader :conditions, :weather, :transport
  attr_accessor :banana_price, :icecream_price, :price_multiplier
  
  
  def initialize
    @price_multiplier = 1
    @icecream_price = 0.25
    @banana_price = 0.02
  end

  def market_conditions
    weather = rand(0..100)
    transport = rand(0..10)
    conditions = weather + transport
    case conditions
    when 100..110
      self.price_multiplier *= 5
    when 50...100
      self.price_multiplier *= 2
    when 0...50
      self.price_multiplier
    end
  end

  def banana_price
    @banana_price * price_multiplier
  end

  def icecream_price
    @icecream_price * price_multiplier
  end
end
