require_relative '../lib/viewer'
require_relative '../lib/input'
#require_relative '../lib/day'
require_relative '../lib/day_controller'
describe DayController do
  before do
    # @inventory = double(:money => 5)
    # @climate = double()
    # @foot_traffic = double()
    # @market = double()
    @day = double() #Day.new(@inventory, @climate, @foot_traffic, @market)
    @day_counter = 0
    @viewer = double()
    @input = double()
    
    @day_controller = DayController.new(@day,@viewer,@input, @day_counter)
  end
  #let :day_controller{DayController.new(@day,@viewer,@input, @day_counter)}
  
  context "Given I initialize the day progression of the game" do
    it "should give me a welcome message" do
      allow(@day).to receive(:account_balance).and_return(5)
      expect(@viewer).to receive(:welcome)
      @day_controller.welcome_to_game
    end
  end

  context "given I define a selling price at the start of the day" do
    it "should be correctly assigned to the product selling price" do
      return_value = 10
      expect(@day).to receive(:set_product_price)
      expect(@day_controller).to receive(:display_market_rates)  
      expect(@input).to receive(:get_input).and_return(return_value)
      
      @day_controller.define_selling_price
      
    end
  end
  context "Given I check the weather for the day" do
    it "should return me a view response" do
    expect(@day).to receive(:climate)
    expect(@viewer).to receive(:weather_report)

    @day_controller.display_weather_report
    end
  end

  # context "Given I check the market" do
  #   it "should give me the market prices" do
  #   expect(@viewer).to receive(:market_price_message)
  #   expect(@day).to receive(:market).with(:banana_price)
  #   #expect(@market).to receive(:banana_price)
  #   #expect(@market).to receive(:icecream_price)
  #   #expect(@market).to receive(:break_even_price)

  #   @day_controller.display_market_rates
  #   end
  # end
  context "Given I check my bank balance" do
    it "should return a view of my balance" do
      expect(@viewer).to receive(:bank_balance)
      expect(@day).to receive(:inventory)
      expect(@inventory).to receive(:money).and_return(4)

      @day_controller.display_bank_balance
    end
  end
  context "Given I check the foot traffic report." do
    it "should return a projected count of walkers for the day" do
      expect(@viewer).to receive(:walker_report)
      expect(@day).to receive(:foot_traffic)

      @day_controller.display_foot_traffic
    end
  end

  context "Given I kick off a product purchase" do
    it "should allow me to buy a product" do
      expect(@viewer).to receive(:supplies_message)
      expect(@day).to receive(:stock_to_purchase)
      allow(@day).to receive(:inventory)
      allow(@inventory).to receive(:stock)
      allow(@stock).to receive(:length)
      expect(@input).to receive(:get_input)
      
      @day_controller.select_product_to_buy
    end
    it "should allow me to set a product quantity" do
      expect(@viewer).to receive(:buy_supplies_message)
      expect(@day).to receive(:quantity_to_purchase)
      expect(@input).to receive(:get_input).and_return(2)

      @day_controller.quantity_of_product_to_buy
    end
    
    it "should allow the product to be bought if they have money" do

    end
  end
end 

#Read LETS - Rspec and how mocking syntax is used