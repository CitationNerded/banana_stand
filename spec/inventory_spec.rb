require 'inventory'
describe Inventory do
  before do
    @inventory = Inventory.new
  end

  describe "Given I begin with some money and zero products" do
    it "Should return default initialized values" do
      expect(@inventory.money).to equal 5
      expect(@inventory.stock.values[0]).to equal 0
      expect(@inventory.stock.values[1]).to equal 0
    end
  end
  describe "Given I wish to buy some products" do
    it "should be possible to buy a default quantity of product" do
      @inventory.buy_stock(@inventory.stock.keys[0], 0.5)
      expect(@inventory.stock.values[0]).to equal 1
      expect(@inventory.money).to equal 4.5
    end

    it "should be possible to specify quantity of stock to buy" do
      @inventory.buy_stock(@inventory.stock.keys[0], 0.5, 8)
      expect(@inventory.stock.values[0]).to equal 8
      expect(@inventory.money).to equal 1.0
    end

    it "should be possible to bring your wallet down to 0 and not be denied service" do
      @inventory.buy_stock(@inventory.stock.keys[1], 0.5, 10)
      expect(@inventory.stock.values[1]).to equal 10
      expect(@inventory.money).to equal 0.0
    end

    it "should not be possible to buy more than you can afford" do
      @inventory.buy_stock(@inventory.stock.keys[0], 0.5, 20)
      expect(@inventory.stock.values[0]).to equal 0
      expect(@inventory.money).to equal 5
    end
  end

  describe "Given I wish to make some product" do
    before do
      @inventory.stock[@inventory.stock.keys[0]] = 7
      @inventory.stock[@inventory.stock.keys[1]] = 10
    end
    
    it "should be possible to make a default product quantity" do
      @inventory.make_product(@inventory.sellable_product.keys[0])
      expect(@inventory.sellable_product.values[0]).to equal 1
      expect(@inventory.stock.values[0, 2]).to eq [6, 9]  
    end

    it "should be possible to define the quantity you wish to make" do
      @inventory.make_product(@inventory.sellable_product.keys[0] ,3)
      expect(@inventory.sellable_product.values[0]).to equal 3
      expect(@inventory.stock.values[0, 2]).to eq [4, 7]  
    end

    it "should not be possible to make more product than the raw resources allow" do
      @inventory.make_product(@inventory.sellable_product.keys[0], 40)
      expect(@inventory.sellable_product.values[0]).to equal 7
      expect(@inventory.stock.values[0, 2]).to eq [0, 3]  
 
    end

    it "should not be possible to make more product even if the user has enough of one required resource" do
      @inventory.make_product(@inventory.sellable_product.keys[0], 8)
      expect(@inventory.sellable_product.values[0]).to equal 7
      expect(@inventory.stock.values[0, 2]).to eq [0, 3]  
    end
  end

  describe "Given I wish to sell products" do
    before do
      @inventory.sellable_product[@inventory.sellable_product.keys[0]] = 10
    end

    it "should be possible to sell products" do
      @inventory.sell_product(1, 100)
      expect(@inventory.sellable_product.values[0]).to equal 0
      expect(@inventory.money).to equal 15
    end

    it "should not be possible to sell more products than I currently have in stock" do
      banana_splits_before_sale = @inventory.sellable_product.values[0]
      @inventory.sell_product(10, 100)

      expect(@inventory.actual_buyers).to equal banana_splits_before_sale
      expect(@inventory.money).to equal 105
    end

    it "My financial situation should improve to reflect sold product" do
      money_before_sales = @inventory.money
      @inventory.sell_product(10,100)
      expect(@inventory.money).to be > money_before_sales
    end

    it "I should not be able to sell more product than potential shoppers" do
      @inventory.sell_product(10,5)
      expect(@inventory.sellable_product.values[0]).to equal 5
    end
  end
end 