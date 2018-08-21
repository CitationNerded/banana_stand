#At the beginning of the day in this order:

#The climate is inialized. This helps to determine the market conditions and is passed into the market. 
#The climate relies on the previous days climate. protected method comparison?
#The market is inialized. this sets the market conditions for the day for shopping.
#The number of people that will walk by the banana stand is calculated from the climate.

#The user is prompted for input on how many bananas and icecream scoops they wish to buy.
#The user is prompted on how many banana splits they wish to make.
#The user is prompted on how much they want banana splits to cost for the day

#The number of people  that will buy from the banana stand is now calculated
class Day
  include Viewer
  @@days_survived = -1

  def initialize
    @@days_survivied += 1
    @market = Market.new
    @market.market_conditions
  end
end