# scripts/feedback_after_user_input.rb

require_relative './streaming_pour_logic'

# Simulated heart rate sampling over time
class HeartRateSensorSim
  def initialize
    @simulated_values = [88, 90, 92, 95, 97, 99, 100, 98, 96, 95]
    @index = 0
  end

  def read
    value = @simulated_values[@index % @simulated_values.length]
    @index += 1
    value
  end
end

# Gather heart rate while user answers questions
hr_sensor = HeartRateSensorSim.new
hr_stream = []

puts "Welcome to SommelAI 🍷"
puts "While you answer a few questions, we’ll be reading your heart rate...\n"

3.times do
  print "."
  sleep 1
  hr_stream << hr_sensor.read
end
puts "\n"

puts "📖 What is your mood today?"
emotions = [
  "Celebrate", "Relaxing", "Thoughtful", "Romantic",
  "Reflective", "On Vacation", "Calm/Fresh"
]
emotions.each_with_index { |e, i| puts "#{i + 1}. #{e}" }
print "> "
selected = gets.chomp.to_i - 1
emotion = emotions[selected] || "Calm/Fresh"

3.times do
  print "."
  sleep 1
  hr_stream << hr_sensor.read
end
puts "\n"

print "👤 Are you alone? (yes/no): "
alone_input = gets.chomp.downcase
alone = alone_input.start_with?("y")

3.times do
  print "."
  sleep 1
  hr_stream << hr_sensor.read
end
puts "\n"

# Final average HR
avg_hr = hr_stream.sum.to_f / hr_stream.size
puts "💓 Average HR during session: #{avg_hr.round(1)} bpm"

# Make one decision
logic = StreamingPourLogic.new(heart_rate_bpm: avg_hr, emotion: emotion, alone: alone)
decision = logic.decision

puts "\n🥂 SommelAI Final Recommendation:"
puts "Wine: #{decision[:wine]}"
puts "Volume: #{decision[:volume]}"
puts "Pour Style: #{decision[:pour_style]}"
puts "Vessel: #{decision[:glass_or_vessel]}"
puts "(Glass Icon: #{decision[:icon_path]})"

puts "\n🤖 [Decision made based on your mood and average heart rate across the session]"
