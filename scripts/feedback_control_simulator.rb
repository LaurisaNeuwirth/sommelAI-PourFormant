require_relative './streaming_pour_logic'

# PID Controller simulation for pour speed adjustment
class PIDController
  def initialize(kp:, ki:, kd:)
    @kp = kp
    @ki = ki
    @kd = kd
    @prev_error = 0.0
    @integral = 0.0
  end

  def update(target, current)
    error = target - current
    @integral += error
    derivative = error - @prev_error
    @prev_error = error

    # Control output (e.g., adjusted pour duration or speed)
    @kp * error + @ki * @integral + @kd * derivative
  end
end

# Simulated HR time series (10 readings over time)
time_series_hr = [88]()
