class Grid
  def initialize(options)
    @rows, @cols, @win_count = options.values_at(:rows, :columns, :win_count)
    @grid = Array.new(@rows) { Array.new(@cols) }
  end

  def over?
    check_horizontals || check_verticals || check_diagonals
  end

  def place_token(col, symbol)
    return false unless valid_column?(col)
    col = Integer(col)
    row = find_available_row(col)

    @grid[row][col] = symbol

    true
  end

  def render
    print " "
    @cols.times { |i| print "#{i}   " }
    puts
    @grid.each_with_index do |row, i|
      row.each_with_index do |spot, j|
        print j == 0 ? " " : " | "

        print spot.nil? ? " " : spot
      end
      puts
      print "____" * @cols
      puts
    end
  end

  private

  def check_diag(quad, first_token, pos)
    multipliers = {
      quad1: [-1, -1],
      quad2: [-1,  1],
      quad3: [ 1,  1],
      quad4: [ 1, -1]
    }

    (0...@win_count).all? do |diff|
      row_dx = diff * multipliers[quad][0]
      col_dx = diff * multipliers[quad][1]

      break if pos[0] + row_dx < 0 || pos[0] + row_dx >= @rows
      break if pos[1] + col_dx < 0 || pos[1] + col_dx >= @cols

      first_token == @grid[pos[0] + row_dx][pos[1] + col_dx]
    end
  end

  def check_diagonals
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        first_token = @grid[i][j]
        next if first_token.nil?
        pos = [i, j]

        return true if check_diag(:quad1, first_token, pos) ||
          check_diag(:quad2, first_token, pos) ||
          check_diag(:quad3, first_token, pos) ||
          check_diag(:quad4, first_token, pos)
      end
    end

    false
  end

  def check_horizontals
    check_lines(@grid)
  end

  def check_lines(grid)
    grid.each do |row|
      (0..(row.length - @win_count)).each do |i|
        first_token = row[i]
        next if first_token.nil?

        if row[i...(i + @win_count)].all? { |token| token == first_token }
          return true
        end
      end
    end

    false
  end

  def check_verticals
    check_lines(@grid.transpose)
  end

  def find_available_row(col)
    (@grid.length - 1).downto(0) do |row|
      next unless @grid[row][col].nil?
      return row
    end
  end

  def full_column?(col)
    @grid.none? { |row| row[col].nil? }
  end

  def valid_column?(col)
    return false unless col.chars.all? { |char| char =~ /[0-9]/ }
    col = Integer(col)

    !full_column?(col) && (col >= 0) && (col < @cols)
  end
end
