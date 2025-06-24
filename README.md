
# SommelAI

SommelAI is a Ruby-based simulation of a robotic sommelier that selects and “pours” wine based on user emotion, heart rate, and social context. It applies principles from (1) PID feedback control (2) signal smoothing and (3) state-based decision modeling to create a playful, technically grounded example of how robotics might interact with human inputs.

This project was originally developed during a startup weekend in Paris and is now maintained as a showcase of real-time control strategies and intelligent behavior mapping for robotic systems.

---

## 🎯 Project Goals

SommelAI is not a production app. It is designed to:

- Demonstrate robotic control loop principles (PID)
- Use sliding window smoothing to process time-series inputs
- Apply decision logic to modulate behavior based on context
- Serve as a creative and technically clear example of feedback control + decision mapping

---

## ⚙️ Engineering Concepts Demonstrated

### 1. PID Feedback Control
The project uses a PID controller to adjust wine pouring behavior based on the difference between a target heart rate and a smoothed, real-time heart rate average. This mimics robotic control loops where actions are constantly corrected based on sensor input.

### 2. Sliding Window Input Processing
A fixed-size buffer smooths noisy heart rate data over time, simulating how real robotic systems avoid reacting to outliers or spikes. This supports stable, expressive pour behavior over time.

### 3. Contextual State Mapping
User emotion, heart rate state, and social context (alone or with others) are mapped to:
- Wine type (e.g. Bourgogne, Champagne)
- Pour volume
- Pour style
- Glass or vessel (e.g. coupe, carafe)

All decision logic is centralized and modular in the `StreamingPourLogic` class.

---

## 🗃️ Why There’s No Real Database

This project intentionally **does not include persistent data storage** like a full SQLite workflow. While session data could be logged, the project is focused on real-time behavior and control logic — not persistence or UI.

All output is presented in the console for simplicity and clarity.

---

## 📂 Project Structure

| File | Description |
|------|-------------|
| `feedback_after_user_input.rb` | CLI interface that collects emotion and social context, simulates heart rate input, and generates a personalized pour decision |
| `feedback_control_with_window.rb` | Time-series simulation using a sliding window and PID controller to demonstrate smooth, responsive behavior over time |
| `simulate_input.rb` | Lightweight demo script for testing single-input decisions quickly |
| `streaming_pour_logic.rb` | Central decision engine that maps input states to wine type, volume, pour style, and vessel |
| `db/setup.rb` (optional) | Schema setup script for a SQLite database (not currently required or used) |

---

## 🧪 Example Outputs

CLI responses include:
- Emotion and social prompts
- Simulated heart rate stream or snapshot
- Final pour recommendation:
  - 🥂 Wine Type
  - 🍷 Glass or Carafe
  - 📏 Pour Volume
  - 🎨 Pour Style
  - 🖼️ Icon Path

---

## 🚀 Running the Project

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/sommelai.git
   cd sommelai
````

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Run one of the scripts:

   * Interactive session:

     ```bash
     ruby scripts/feedback_after_user_input.rb
     ```
   * Simulated control loop:

     ```bash
     ruby scripts/feedback_control_with_window.rb
     ```
   * Quick test:

     ```bash
     ruby scripts/simulate_input.rb
     ```

---

## 🧠 Future Ideas

* Add visual pour animation
* Replace HR simulation with live input
* Log decisions or generate session reports

---

## 🥂 About the Project

SommelAI was created during a startup weekend in Paris as a whimsical, technically sound project to explore robotics-inspired behavioral design. It continues to evolve as a personal showcase of engineering creativity and control logic fundamentals.

---