# SommelAI – Wine Pour Logic Simulator
# SommelAI 🍷

A whimsical but technically grounded simulation project reconstructing a 2017 concept to demonstrate feedback control loop design and robotic manipulation logic.

---

## Project Intent
This project was built as part of a group technical competition and I am reconstituting it to demonstrate my h to 

Rather than building a hardware prototype, this simulation reimagines a project originally conceived in Paris in 2017: a playful robotic wine sommelier displayed on-screen. The updated version demonstrates core robotic control system concepts using modern simulation techniques and plain Ruby logic — portable, testable, and educational.

---

## 🎭 Concept Overview
What if a robot could respond to your heart rate and emotional state in order to select the perfect wine to pour, with the perfect amount for your current situation?

This project explores that using:

- Simulated heart rate streaming input
In the original project, we used a Microsoft Band 2 connected to a PC via USB to provide real-time data thru the Microsoft Health API
- Emotion-based decision rules based on live Q & A submitted in real time by the user
- A control loop that determines pour behavior, volume, correct type of wine glass, and a carafe if there were more than 1 person according to user input.

This codebase models the decision architecture of a robotic wine pourer, and lays the groundwork for future robotic implementations involving real sensors, servos, and manipulators.

---

## 🤖 Engineering Concepts Demonstrated

### ✅ 1. Feedback Control Loops
- A PID controller adjusts pour speed based on the error between target and actual heart rate
- Simulates how a robot modulates motion over time with streaming input

### ✅ 2. State Mapping and Behavioral Modeling
- Heart rate is bucketed into "High" or "Low" categories
- Combined with emotion state to determine motion logic
- Maps emotional context to wine type and delivery style

### ✅ 3. Robotic Manipulator Planning (Simulated)
- Outputs include:
  - Wine selection
  - Pour volume (single or carafe)
  - Glassware (e.g., Coupe, Verre à Bourgogne)
  - Pour style (e.g., “Fast with flourish”, “Slow & lingered”)
- Pour speed is dynamically adjusted via PID feedback

> While no physical robot is used here, all control decisions are modeled as if they were to be executed by a robotic manipulator.

---

## 🧪 How It Works
- `streaming_pour_logic.rb`: core logic engine
- `simulate_input.rb`: interactive emotion/HR simulation
- `feedback_control_simulator.rb`: full PID-driven loop over time-series heart rate data

Run using:
```bash
ruby scripts/simulate_input.rb
ruby scripts/feedback_control_simulator.rb
```

---

## 🛠️ Future Use in Robotics
While this version is text-based, it can be adapted to:
- Drive real-world robotic arms
- Use sensor input (e.g., heart rate monitors)
- Trigger animations or UI feedback
- Train on human feedback to adapt pouring motion

This project lays a flexible foundation to explore robotics concepts in an accessible and fun context.

---

## 💡 Why This Project?
Because even roboticists need a little wine — and humor — while demonstrating serious technical skills.

Built with 🍷 and precision in Codespaces, on an iPad, as a love letter to rob