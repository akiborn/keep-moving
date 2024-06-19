class HunterThread
  attr_reader :hunter, :mouse

  def initialize(hunter, mouse)
    @hunter = hunter
    @mouse = mouse
  end

  def start
    Thread.new do
      hunter.spawn_somewhere(Curses.cols, Curses.lines)
      draw_hunter

      until mouse.caught?
        hunter.move(mouse.x, mouse.y)
        draw_hunter
        Thread.pass
      end
    end
  end

  private

    def draw_hunter
      hunter.prev_body.each do |x, y|
        Curses.setpos(y - 1, x - 1)
        Curses.addstr(' ')
      end
      hunter.body[1..].each do |x, y|
        Curses.setpos(y - 1, x - 1)
        Curses.addstr('•')
      end
      x, y = hunter.body[0]
      Curses.setpos(y - 1, x - 1)
      Curses.addstr('o')
    end
end
