require_relative './viewer'

class Market
  include Viewer
  attr_reader :market_prices
  attr_accessor :banana_price, :icecream_price, :price_of_split, :split_price
  
  def initialize
  end

  def market_conditions(conditions = random_demand)
    if market_conditions_have_been_assessed?
      puts "this has already been reviewed"
    else
      case conditions
      when 8..10
        @icecream_price = 0.5
        @banana_price = 0.05
      when 4..7
        @icecream_price = 0.40
        @banana_price = 0.035
      when 1..6
        @icecream_price = 0.25
        @banana_price = 0.02
      end
    end
  end
 
  def break_even_price
    minimal_split_price = @banana_price + @icecream_price
    minimal_split_price.round(2)
  end
  
  def market_prices
    market_price_message
  end

  def split_price(set_price)
    @price_of_split = set_price
  end

  private

  def random_demand
    rand(1..10)
  end
  
  def market_conditions_have_been_assessed?
    (icecream_price && banana_price) != nil
  end
end