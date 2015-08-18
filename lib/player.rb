class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name, @symbol = name, symbol
  end

  def take_turn
    puts "Choose a column to place token: "
    input = gets.chomp.strip

    input
  end
end
