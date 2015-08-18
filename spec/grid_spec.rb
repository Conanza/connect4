require "grid"

describe Grid do
  before(:each) do
    @grid = Grid.new({ rows: 4, columns: 4, win_count: 3 })
  end

  describe "#full_column?" do
    it "should recognize full columns" do
      4.times { @grid.place_token("0", :x) }

      expect(@grid.send(:full_column?, 0)).to be_truthy
    end
  end

  describe "#over?" do
    it "should recognize a vertical win" do
      3.times { @grid.place_token("0", :x) }

      expect(@grid.over?).to be_truthy
    end

    it "should recognize a horizontal win" do
      3.times { |i| @grid.place_token(i.to_s, :x) }

      expect(@grid.over?).to be_truthy
    end

    it "should recognize a diagonal win" do
      @grid.place_token("0", :x)
      @grid.place_token("1", :o)
      @grid.place_token("1", :x)
      2.times { |i| @grid.place_token("2", :o) }
      @grid.place_token("2", :x)

      expect(@grid.over?).to be_truthy
    end

    it "should recognize another diagonal win" do
      @grid.place_token("2", :x)
      @grid.place_token("1", :o)
      @grid.place_token("1", :x)
      2.times { |i| @grid.place_token("0", :o) }
      @grid.place_token("0", :x)

      expect(@grid.over?).to be_truthy
    end

    it "should recognize another another diagonal win" do
      @grid.place_token("2", :x)
      @grid.place_token("1", :o)
      @grid.place_token("0", :x)
      @grid.place_token("2", :x)
      @grid.place_token("1", :o)
      @grid.place_token("1", :x)
      2.times { |i| @grid.place_token("0", :o) }
      @grid.place_token("0", :x)

      expect(@grid.over?).to be_truthy
    end
  end
end
