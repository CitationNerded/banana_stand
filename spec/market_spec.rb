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

    it "has been set to high" do
      @market.market_conditions(10)

      expect(@market.icecream_price).to equal 0.5
      expect(@market.banana_price).to equal 0.05
    end

    it "has been set to low" do
      @market.market_conditions(1)

      expect(@market.icecream_price).to equal 0.25
      expect(@market.banana_price).to equal 0.02
    end

    it "is run with undefined inputs" do
      @market.market_conditions

      expect(@market.icecream_price).to_not equal nil
      expect(@market.banana_price).to_not equal nil
    end
  end

  describe "Given I want to calculate break even price of goods" do
    it "should equal the sum of bananas and icecream" do
      @market.market_conditions(10)

      expect(@market.break_even_price).to equal (@market.banana_price + @market.icecream_price)
      expect(@market.break_even_price).to be_a Float
    end
  end

  describe "Given I wish to set the price of a banana split" do
    it "should default to a float value" do
      @market.split_price(1)

      expect(@market.price_of_split).to equal 1.0
      expect(@market.price_of_split).to be_a Float
    end

    it "should be definable" do
      @market.split_price(300)

      expect(@market.price_of_split).to equal 300.0
      expect(@market.price_of_split).to be_a Float
    end
  end

  describe "Given there is market interest" do
    it "should be possible without user input" do
      @market.split_price(2)
      @market.market_interest(12, 2, 2)
      
      expect(@market.interest_in_product).to be 3
      expect(@market.interest_in_product).to be_a Integer
    end
  end
end