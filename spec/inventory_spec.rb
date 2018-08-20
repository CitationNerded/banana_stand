require 'inventory'
require_relative '../lib/market.rb'

describe Inventory do
  before do
    starting_money = 5
    banana_split_price = 10
    @user_inventory = Inventory.new(banana_split_price, starting_money)
  end
  
  describe "Given I have starting inventory" do
    it "and I do not make any purchases" do
      expect(@user_inventory.icecream_scoop).to equal 0
      expect(@user_inventory.banana).to equal 0
      expect(@user_inventory.money).to equal 5
    end
  end

  describe "Given I buy bananas" do
    it "should increase my banana inventory by the default value" do
      @user_inventory.buy_banana

      expect(@user_inventory.banana).to equal 1
      expect(@user_inventory.money).to equal 4.75

    end

    it "should increase my banana inventory by the defined amount" do
      @user_inventory.buy_banana(5)

      expect(@user_inventory.banana).to equal 5
      expect(@user_inventory.money).to equal 3.75
    end

    it "should not allow me to buy beyond my financial situation." do
      @user_inventory.buy_banana(20)

      expect(@user_inventory.banana).to equal 0
      expect(@user_inventory.money).to equal 5
    end
  end

  describe "Given I buy icecream" do
    it "should increase my icecream scoop inventory by the default value." do
      @user_inventory.buy_icecream
     
      expect(@user_inventory.icecream_scoop).to equal 1
      expect(@user_inventory.money).to equal 4.5

    end

    it "should increase my icecream scoop inventory by the defined amount." do
      @user_inventory.buy_icecream(5)

      expect(@user_inventory.icecream_scoop).to equal 5
      expect(@user_inventory.money).to equal 2.5
    end

    it "should not allow me to buy beyond my financial situation." do
      @user_inventory.buy_icecream(20)

      expect(@user_inventory.icecream_scoop).to equal 0
      expect(@user_inventory.money).to equal 5
    end
  end

  describe "Give I want to make banana splits" do
    before do
      @user_inventory.buy_banana(2)
      @user_inventory.buy_icecream(2)
    end

    it "should use one banana and icecream scoop for each banana split" do
      @user_inventory.make_split
      
      expect(@user_inventory.banana).to equal 1
      expect(@user_inventory.icecream_scoop).to equal 1
      expect(@user_inventory.banana_splits).to equal 1
    end

    it "should not let me make product beyond my inventory stock" do
      @user_inventory.make_split(3)

      expect(@user_inventory.banana).to equal 2
      expect(@user_inventory.icecream_scoop).to equal 2
      expect(@user_inventory.banana_splits).to equal 0
    end
  end
end