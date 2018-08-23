class Market
  attr_reader :banana_price, :icecream_price, :price_of_split, :interest_in_product
  
  def market_conditions(conditions = random_demand)
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
 
  def break_even_price
    minimal_split_price = banana_price + icecream_price
    minimal_split_price.round(2)
  end

  def split_price(set_price)
    if set_price <= 0.1
      set_price = 0.1
    end
    @price_of_split = set_price.to_f
  end

  def market_interest(foot_traffic, interest, demand = random_demand)
    market_engagement = ((foot_traffic + interest)/ demand)
    @interest_in_product = ( market_engagement / price_of_split.ceil) #ceil will return the highest whole number of the float
  end

  private

  def random_demand
    rand(1..10)
  end
end
