# scripts/simulate_input.rb

require_relative './streaming_pour_logic'

# Simulated streaming heart rate (in BPM)
streamed_hr_values = [72, 85, 110, 98, 100].cycle

# Example emotion input
puts "Choose your current emotion:"
emotions = [
  "Celebrate",
  "Relaxing",
  "Thoughtful",
  "Romantic",
  "Reflective",
  "On Vacation",
  "Calm/Fresh"
]
emotions.each_with_index { |e, i| puts "#{i + 1}. #{e}" }

print "> "
index = gets.chomp.to_i - 1
emotion = emotions[index] || "Calm/Fresh"

print "Are you alone? (yes/no): "
alone_input = gets.chomp.downcase
alone = alone_input.start_with?("y")

# Get one simulated heart rate
heart_rate_bpm = streamed_hr_values.next
puts "\nSimulated heart rate: #{heart_rate_bpm} bpm"

# Make decision
logic = StreamingPourLogic.new(heart_rate_bpm: heart_rate_bpm, emotion: emotion, alone: alone)
decision = logic.decision

# Display result
puts "\n🥂 SommelAI Recommends:"
puts "Wine: #{decision[:wine]}"
puts "Volume: #{decision[:volume]}"
puts "Pour Style: #{decision[:pour_style]}"
puts "Vessel: #{decision[:glass_or_vessel]}"
puts "(Glass Icon: #{decision[:icon_path]})"
