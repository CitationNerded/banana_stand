require_relative './viewer'
class Input
  def initialize
    @viewer = Viewer.new
  end

  def get_input(valid_selection = 1000)
    loop do
      input = gets.chomp
      return input.to_i if ((input.to_i.to_s == input) && input.to_i <= valid_selection.to_i)
      @viewer.input_unclear
    end
  end
end