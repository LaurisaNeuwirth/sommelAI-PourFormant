# lib/streaming_pour_logic.rb

# This file outlines the core logic for a simulated wine-pouring sommelier bot
# driven by streaming heart rate input and emotion context

class StreamingPourLogic
  attr_reader :hr_state, :emotion, :alone

  def initialize(heart_rate_bpm:, emotion:, alone: true)
    @hr_state = heart_rate_bpm > 95 ? "High" : "Low"
    @emotion = emotion
    @alone = alone
  end

  def decision
    wine, glass, icon = lookup_wine_and_glass(hr_state, emotion)

    vessel = alone ? glass : "Carafe + 2 #{glass}s"
    volume = alone ? (emotion == "On Vacation" ? "120 mL" : "150 mL") : "500 mL"

    pour_style = case emotion
    when "Celebrate"
      alone ? "Fast with flourish" : "Dramatic, shared"
    when "Relaxing", "On Vacation"
      "Lazy & relaxed"
    when "Thoughtful", "Romantic"
      "Slow & lingered"
    when "Reflective"
      "Slow & gentle"
    when "Calm/Fresh"
      "Crisp & refreshed"
    else
      "Smooth"
    end

    {
      wine: wine,
      pour_style: pour_style,
      volume: volume,
      glass_or_vessel: vessel,
      icon_path: icon
    }
  end

  private

  def lookup_wine_and_glass(hr, mood)
    wine_map = {
      ["High", "Celebrate"] => ["Champagne", "Coupe", "icons/coupe.png"],
      ["High", "Relaxing"] => ["Rosé", "Verre tulipe", "icons/tulip.png"],
      ["Low", "Thoughtful"] => ["Bourgogne", "Verre à Bourgogne", "icons/burgundy.png"],
      ["Low", "Romantic"] => ["Bourgogne", "Verre à Bourgogne", "icons/burgundy.png"],
      ["Low", "Reflective"] => ["Pinot Noir", "Verre ballon", "icons/balloon.png"],
      ["Low", "On Vacation"] => ["Rosé", "Verre tulipe", "icons/tulip.png"],
      ["Low", "Calm/Fresh"] => ["Sancerre", "Verre à vin blanc", "icons/white_wine.png"]
    }

    wine_map.fetch([hr, mood], ["Sancerre", hr == "Low" ? "Verre à vin blanc" : "Rosé", "icons/white_wine.png"])
  end
end
