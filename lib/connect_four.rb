require_relative "player"
require_relative "grid"

class ConnectFour
  def initialize(options = {})
    defaults = {
      player1: Player.new("Vision", :o),
      player2: Player.new("Ultron", :x),
      row_count: 6,
      col_count: 7,
      win_count: 4
    }.merge(options)

    @players = defaults.values_at(:player1, :player2)
    row_count, col_count, win_count = defaults.values_at(
      :row_count,
      :col_count,
      :win_count
    )
    @grid = Grid.new({
      rows: row_count,
      columns: col_count,
      win_count: win_count
    })
  end

  def run
    until grid.over?
      system("clear")
      grid.render
      puts "#{players[0].name}'s (#{players[0].symbol}) turn"

      column = players[0].take_turn
      until grid.place_token(column, players[0].symbol)
        puts "Invalid column selection. Try again."
        column = players[0].take_turn
      end

      players.rotate!
    end

    grid.render
    puts "Congrats, #{players[1].name}! You win!"
  end

  private

  attr_reader :grid, :players
end
