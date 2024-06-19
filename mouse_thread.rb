class MouseThread
  attr_reader :mouse

  def initialize(mouse)
    @mouse = mouse
  end

  def start
    Thread.new do
      begin
        # Switch on mouse continous position reporting
        print("\e[?1003h")

        # Also enable SGR extended reporting, because otherwise we can only
        # receive values up to 160x94. Everything else confuses Ruby Curses.
        print("\e[?1006h")

        until mouse.caught?
          next Thread.pass unless Curses.get_char == "\e"
          next Thread.pass unless Curses.get_char == '['

          csi = ''
          loop do
            d = Curses.get_char
            csi += d
            if d.ord >= 0x40 && d.ord <= 0x7E
              break
            end
          end
          if /<(\d+);(\d+);(\d+)(m|M)/ =~ csi
            _button = $1.to_i
            x = $2.to_i
            y = $3.to_i
            _state = $4
            mouse.update(x, y)
          end
          Thread.pass
        end
      ensure
        print("\e[?1003l")
        print("\e[?1006l")
      end
    end
  end
end
