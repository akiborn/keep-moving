class Mouse
  attr_reader :x, :y

  def initialize
    @x = nil
    @y = nil
    @is_caught = false
  end

  def update(x, y)
    @x = x
    @y = y
  end

  def caught!
    @is_caught = true
  end

  def caught?
    @is_caught
  end
end
