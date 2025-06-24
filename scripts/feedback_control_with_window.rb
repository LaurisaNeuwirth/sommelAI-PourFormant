# scripts/feedback_control_with_window.rb

require_relative './streaming_pour_logic'

# 👇 Class to hold a fixed-size sliding window for smoothing input
class HRSlidingWindow
  def initialize(size = 5)
    @size = size
    @window = []
  end

  # Add a new heart rate value, maintaining window size
  def add(value)
    @window << value
    @window.shift if @window.size > @size
  end

  # Calculate average HR over the current window
  def average
    return 0 if @window.empty?
    @window.sum.to_f / @window.size
  end
end

# 👇 Standard PID control implementation
class PIDController
  def initialize(kp:, ki:, kd:)
    @kp = kp  # proportional gain
    @ki = ki  # integral gain
    @kd = kd  # derivative gain
    @prev_error = 0.0
    @integral = 0.0
  end

  # Calculate control output given a target and current value
  def update(target, current)
    error = target - current
    @integral += error
    derivative = error - @prev_error
    @prev_error = error

    # Output control signal
    @kp * error + @ki * @integral + @kd * derivative
  end
end

# 👇 Streaming generator for heart rate values (mimics sensor readings)
def hr_stream
  Enumerator.new do |yielder|
    loop do
      simulated_hr = rand(85..105)  # Simulate fluctuating HR input
      yielder << simulated_hr
      sleep 1  # Mimic 1-second intervals between readings
    end
  end
end

# 👇 Initial setup for session context
target_hr = 95                       # Could be dynamic based on mood
emotion = "Celebrate"               # Pretend input
alone = false                       # Pretend input

puts "\n🎯 Target HR: #{target_hr} bpm"
puts "📖 Emotion: #{emotion}"
puts "👤 Alone?: #{alone ? 'Yes' : 'No'}"
puts "\n📡 Simulating real-time heart rate input with PID control..."

# 👇 Initialize control loop components
pid = PIDController.new(kp: 0.1, ki: 0.05, kd: 0.01)
hr_window = HRSlidingWindow.new(5)

# 👇 Main streaming loop
hr_stream.each_with_index do |hr, t|
  hr_window.add(hr)
  avg_hr = hr_window.average

  # Run PID control to determine pour modulation
  control_output = pid.update(target_hr, avg_hr)

  # Apply wine logic based on smoothed HR, emotion, and social context
  logic = StreamingPourLogic.new(heart_rate_bpm: avg_hr, emotion: emotion, alone: alone)
  decision = logic.decision

  # Map PID output to a "pour adjustment" factor
  pour_speed_adjustment = [[control_output.round(2), -1.0].max, 1.0].min

  # Output decision and control data
  puts "\n⏱️ Time #{t}s"
  puts "💓 Instant HR: #{hr} bpm"
  puts "📊 Smoothed HR (5-sec window): #{avg_hr.round(1)} bpm"
  puts "🥂 Wine: #{decision[:wine]}"
  puts "📏 Volume: #{decision[:volume]}"
  puts "🎨 Pour Style: #{decision[:pour_style]}"
  puts "🍷 Vessel: #{decision[:glass_or_vessel]}"
  puts "🎚️ PID Adjusted Speed Factor: #{pour_speed_adjustment}"

  # Exit after 10 iterations for demonstration purposes
  break if t >= 9
end

puts "\n🤖 [Simulated wine-pouring behavior based on real-time feedback loop]"
