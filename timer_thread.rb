class TimerThread
  attr_reader :timer, :mouse

  def initialize(timer, mouse)
    @timer = timer
    @mouse = mouse
  end

  def start
    Thread.new do
      setup
      timer.start
      until mouse.caught?
        Curses.setpos(Curses.lines - 1, 1)
        Curses.addstr("Timer: #{timer.duration.round(1)}s               ")
        Curses.refresh
        Thread.pass
      end
      timer.stop
    end
  end

  private

    def setup
      Curses.setpos(Curses.lines - 1, 1)
      Curses.addstr('Timer: 0.0s')
      Curses.refresh
      while mouse.x.nil? || mouse.y.nil?
        Thread.pass
      end
    end
end
