require_relative 'boot'

class Game
  include Curses

  attr_reader :timer, :mouse, :hunter

  def initialize
    init_screen
    crmode
    noecho
    curs_set(0)
    Curses.timeout = 10
  end

  def run
    setup
    threads = []
    threads << timer_thread
    threads << mouse_thread
    threads << hunter_thread
    threads << operation_thread
    threads.each(&:join)
    terminate
  ensure
    close_screen
  end

  private

    def timer_thread
      TimerThread.new(timer, mouse).start
    end

    def mouse_thread
      MouseThread.new(mouse).start
    end

    def hunter_thread
      HunterThread.new(hunter, mouse).start
    end

    def operation_thread
      OperationThread.new(hunter, mouse).start
    end

    def setup
      @timer = Timer.new
      @mouse = Mouse.new
      @hunter = Hunter.new([lines, cols].max / 2, [lines, cols].min / 2)

      display_center('How many seconds can you RUN AWAY from hunter?')
      display_center('HUNTER: o••••', offset: 1)
      refresh
      sleep 5

      clear
      refresh
    end

    def terminate
      clear
      display_center('You are caught!')
      display_center("Record: #{timer.record.round(1)}s", offset: 1)
      refresh
      sleep 3
    end

    def display_center(text, offset: 0)
      setpos(lines / 2 + offset, (cols - text.length) / 2)
      addstr(text)
    end
end

game = Game.new
game.run
