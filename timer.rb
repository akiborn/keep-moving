class Timer
  attr_reader :start_at, :stop_at

  def initialize
    @start_at = nil
    @stop_at = nil
  end

  def start
    @start_at = Time.now.to_f
  end

  def stop
    @stop_at = Time.now.to_f
  end

  def duration
    return nil if start_at.nil?

    Time.now.to_f - start_at
  end

  def record
    return nil if start_at.nil? || stop_at.nil?

    stop_at - start_at
  end
end
