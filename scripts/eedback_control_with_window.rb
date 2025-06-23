# scripts/feedback_control_with_window.rb

require_relative './streaming_pour_logic'

# Sliding window class for smoothing HR input
class HRSlidingWindow
  def initialize(size = 5)
    @size = size
    @window = []
  end

  def add(value)
    @window << value
    @window.shift if @window.size > @size
  end

  def average
    return 0 if @window.empty?
    @window.sum.to_f / @window.size
  end
end

# PID Controller
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

    @kp * error + @ki * @integral + @kd * derivative
  end
end

# Simulated heart rate stream
time_series_hr = [88, 90, 92, 95, 97, 99, 100, 98, 96, 95]

# Target and context
target_hr = 95
emotion = "Celebrate"
alone = false

# Init PID and sliding window
pid = PIDController.new(kp: 0.1, ki: 0.05, kd: 0.01)
hr_window = HRSlidingWindow.new(5)

puts "\n🎯 Target HR: #{target_hr}"
puts "📖 Emotion: #{emotion}"
puts "👤 Alone?: #{alone ? 'Yes' : 'No'}"
puts "\nSimulating heart rate with smoothing window..."

# Main loop
time_series_hr.each_with_index do |hr, t|
  hr_window.add(hr)
  avg_hr = hr_window.average

  control_output = pid.update(target_hr, avg_hr)
  logic = StreamingPourLogic.new(heart_rate_bpm: avg_hr, emotion: emotion, alone: alone)
  decision = logic.decision

  pour_speed_adjustment = [[control_output.round(2), -1.0].max, 1.0].min

  puts "\n⏱️ Time #{t}s"
  puts "💓 HR: #{hr} bpm"
  puts "📊 Avg HR (5-sec window): #{avg_hr.round(1)} bpm"
  puts "🥂 Wine: #{decision[:wine]}"
  puts "📏 Volume: #{decision[:volume]}"
  puts "🎨 Pour Style: #{decision[:pour_style]}"
  puts "🍷 Vessel: #{decision[:glass_or_vessel]}"
  puts "🎚️ PID Adjusted Speed: #{pour_speed_adjustment}"
end

puts "\n🤖 [Manipulator would use smoothed HR for graceful pour adjustment over time]"
