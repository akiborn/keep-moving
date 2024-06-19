class OperationThread
  attr_reader :hunter, :mouse

  def initialize(hunter, mouse)
    @hunter = hunter
    @mouse = mouse
  end

  def start
    Thread.new do
      until mouse.caught?
        next Thread.pass if mouse.x.nil? || mouse.y.nil?

        mouse.caught! if hunter.body.include?([mouse.x, mouse.y])
        Thread.pass
      end
    end
  end
end
