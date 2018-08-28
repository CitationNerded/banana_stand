require_relative '../lib/market'
require_relative '../lib/inventory'
require_relative '../lib/climate'
require_relative '../lib/day'
require_relative '../lib/foot_traffic'
describe Day do
  before do
    @inventory = Inventory.new
    @climate = Climate.new
    @foot_traffic = FootTraffic.new
    @market = Market.new
    @day = Day.new(@inventory, @climate, @foot_traffic, @market)
    
    #Stub randomized prices
    @day.market.banana_price = 0.05
    @day.market.icecream_price = 0.5
    @day.foot_traffic = @day.foot_traffic.walker_forecast(@day.climate.weather)
  end
  
  describe "Given I start a new day" do
    it "should initilize all required components for a business day" do
      @day.set_product_price(2)
      expect(@day.market.price_of_product).to equal 2.0
    end
  end
  
  describe "given I want to buy product at the start of the day" do
    it "should allow me to purchase a valid product" do
      @day.stock_to_purchase(1)
      @day.quantity_to_purchase(2)
      @day.purchase_stock
      expect(@day.inventory.money).to equal 4.90
      expect(@day.inventory.stock[@day.inventory.stock.keys[0]]).to equal 2
    end
  end
  
  describe "given I establish buyers" do
    it "should give me potential buyers to sell to" do
      @day.set_product_price(2)
      @day.establish_buyers
     end
  end

  describe "given I make a product" do
    it "should create a product" do
      @day.inventory.stock[@day.inventory.stock.keys[0]] = 10
      @day.inventory.stock[@day.inventory.stock.keys[1]] = 10

      @day.product_to_make(1)
      @day.quantity_to_make(5)
      @day.make_product

      expect(@day.inventory.sellable_product).to eq({"Banana Split"=>5})
    end
  end

  describe "Given I check the loss conditions" do
    it "and I have not lost the game" do
      expect(@day.loss_condition?).to equal false
    end
    
    it "and I have lost the game as I have no money" do
      @day.inventory.money = 0

      expect(@day.loss_condition?).to equal true
    end

    it "and I have no money but I have some prodycts" do
      @day.inventory.money = 0
      @day.inventory.stock[@day.inventory.stock.keys[0]] = 1
      @day.inventory.stock[@day.inventory.stock.keys[1]] = 1
    
      expect(@day.loss_condition?).to equal false
    end
  end

  describe "Given I want to establish how much profit I made today" do
    it "I should be able to see my profit/loss assuming no sales or purchases" do
      @day.establish_profit
      expect(@day.net_profit).to equal 0
    end

    it "I should be able to see my losses assuming i bought product but made no sales" do
      @day.stock_to_purchase(1)
      @day.quantity_to_purchase(50)
      @day.purchase_stock

      @day.establish_profit

      expect(@day.net_profit).to equal -2.5
    end

    it "I should see my profits assuming I made sales" do
      @day.set_product_price(5)
      @day.inventory.sellable_product[@day.inventory.sellable_product.keys[0]] = 5

      @day.establish_buyers
      @day.sell_product
      @day.establish_profit

      expect(@day.net_profit).to equal 25.0
    end
  end
  describe "Given I want to throw away surplus product at the end of each day" do
   it "should set products to zero" do
    @day.inventory.sellable_product[@day.inventory.sellable_product.keys[0]] = 5
    @day.destroy_product_surplus
    expect(@day.inventory.sellable_product[@day.inventory.sellable_product.keys[0]]).to equal 0
    end
  end
end