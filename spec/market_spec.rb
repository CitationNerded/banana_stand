require 'market'
describe Market do
  before do
    @market = Market.new
  end

  describe "Given market conditions" do
    it "have not yet been assessed for the day" do
      expect(@market.icecream_price).to equal nil
      expect(@market.banana_price).to equal nil
    end

    it "have been initialized for the day" do
      @market.market_conditions
      initial_value_of_icecream = @market.icecream_price
      initial_value_of_banana = @market.banana_price

      expect(initial_value_of_icecream).to_not equal nil
      expect(initial_value_of_banana).to_not equal nil
    end

    it "have been re-initialized" do
      @market.market_conditions
      initial_value_of_icecream = @market.icecream_price
      initial_value_of_banana = @market.banana_price

      @market.market_conditions
      new_value_of_icecream = @market.icecream_price
      new_value_of_banana = @market.banana_price

      expect(initial_value_of_icecream).to_not equal new_value_of_icecream
      expect(initial_value_of_banana).to_not equal new_value_of_banana
    end
  end

  describe "Given I want to calculate break even price of goods" do
    it "should return a complatible value" do
      @market.market_conditions

      expect(@market.break_even_price).to be_a Float
    end
  end

  describe "Given I wish to set the price of a banana split" do
    it "should default to a float value" do
      @market.product_price(1)

      expect(@market.price_of_product).to equal 1.0
      expect(@market.price_of_product).to be_a Float
    end

    it "should be definable" do
      @market.product_price(300)

      expect(@market.price_of_product).to equal 300.0
      expect(@market.price_of_product).to be_a Float
    end
  end

  describe "Given there is market interest" do
    it "should be possible without user input" do
      @market.product_price(2)
      @market.market_interest(12, 2, 2)
      
      expect(@market.interest_in_product).to be 3
      expect(@market.interest_in_product).to be_a Integer
    end
  end
end