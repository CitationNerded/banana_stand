class Market
  attr_accessor :banana_price, :icecream_price, :pricing_board
  attr_reader :price_of_product, :interest_in_product
  
  def market_conditions
      @icecream_price = rand(0.25..0.5)
      @banana_price = rand(0.02..0.05)

      #UNIMPLEMENTED - if necessary convert prices to a hash and then transform break_even_price to take the value of what product the customer wishes to make.
      pricing_board = {"icecream" => rand(0.25..0.5), "banana" => rand(0.02..0.05),"sugar" => rand(0.02..0.05), "lemon" => rand(0.25..0.5)}
  end
 
  def break_even_price
    minimal_product_price = banana_price + icecream_price
    minimal_product_price
  end

  def product_price(set_price)
    if set_price <= 0.1
      set_price = 0.1
    end
    @price_of_product = set_price.to_f
  end

  def market_interest(foot_traffic, interest, demand = random_demand)
    market_engagement = ((foot_traffic + interest)/ demand)
    @interest_in_product = ( market_engagement / price_of_product.ceil) #ceil will return the highest whole number of the float
  end

  private

  def random_demand
    rand(1..10)
  end
end
