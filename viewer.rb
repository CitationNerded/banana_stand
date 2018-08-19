class Viewer
  def balance_sheet
    puts "You have #{@money} money in the banana stand"
    puts "You currently have #{@banana} bananas  at a cost of $#{@banana_cost} and #{@icecream_scoop} icecream scoops at a cost of $#{@icecream_cost}."
    puts "You have #{@banana_splits} banana splits that you are hoping to sell for $#{@split_price}"
  end
end