class Hunter
  attr_reader :head_x, :head_y, :body, :prev_body, :length, :steps, :steps_per_sec, :last_moved_at

  def initialize(length, initial_steps_per_sec)
    @head_x = nil
    @head_y = nil
    @body = []
    @prev_body = []
    @length = length
    @steps = 0
    @steps_per_sec = initial_steps_per_sec
    @last_moved_at = nil
  end

  def spawn_somewhere(max_x, max_y)
    x = rand(max_x) + 1
    y = rand(max_y) + 1
    spawn(x, y)
  end

  def spawn(x, y)
    @head_x = x
    @head_y = y
    @body = [[head_x, head_y]]
    @steps = 0
    @last_moved_at = Time.now.to_f
  end

  def move(...)
    return unless can_move?

    @prev_body = body
    @body.unshift(next_head_location(...))
    @body = body[0...length]
    @head_x = body[0][0]
    @head_y = body[0][1]
    @last_moved_at = Time.now.to_f
    @steps += 1
    @steps_per_sec += 1 if (steps % 50).zero?
  end

  private

    def can_move?
      Time.now.to_f - last_moved_at > 1.0 / steps_per_sec
    end

    def next_head_location(towards_x, towards_y)
      return [head_x, head_y] if towards_x.nil? || towards_y.nil?
      return [head_x, head_y] if [head_x, head_y] == [towards_x, towards_y]
      return [head_x + 1, head_y] if head_y == towards_y && head_x < towards_x
      return [head_x - 1, head_y] if head_y == towards_y && head_x > towards_x

      distance = Math.hypot(towards_x - head_x, towards_y - head_y)
      radian = Math.acos((towards_x - head_x) / distance)
      case
      when radian < 22.5 / 180 * Math::PI then [head_x + 1, head_y]
      when radian < 67.5 / 180 * Math::PI then [head_x + 1, head_y + (head_y < towards_y ? 1 : -1)]
      when radian < 112.5 / 180 * Math::PI then [head_x, head_y + (head_y < towards_y ? 1 : -1)]
      when radian < 157.5 / 180 * Math::PI then [head_x - 1, head_y + (head_y < towards_y ? 1 : -1)]
      else [head_x - 1, head_y]
      end
    end
end
