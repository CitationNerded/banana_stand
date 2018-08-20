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
end