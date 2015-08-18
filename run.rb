require_relative "lib/connect_four"

if $PROGRAM_NAME == __FILE__
  system("clear")
  puts "WELCOME TO CONNECT FOUR"

  puts "Select: "
  puts "1. for quickplay"
  puts "2. for for custom game"
  puts "3. to quit"
  selection = gets.chomp

  case selection
  when '1'
    new_game = ConnectFour.new
  when '2'
    puts "\nPlayer 1, enter your name:"
    player1 = gets.chomp
    puts "\nPlayer 2, enter your name:"
    player2 = gets.chomp

    puts "\nEnter gameplay options:"
    puts "Number of grid ROWS?"
    row_count = Integer(gets.chomp)
    puts "Number of grid COLUMNS?"
    col_count = Integer(gets.chomp)
    puts "How many pieces to connect for a win?"
    win_count = Integer(gets.chomp)

    new_game = ConnectFour.new({
      player1: Player.new(player1, :o),
      player2: Player.new(player2, :x),
      win_count: win_count,
      col_count: col_count,
      row_count: row_count
    })
  when '3' then exit
  end

  new_game.run
end
