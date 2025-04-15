import SwiftUI

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    
    // User selections
    @State private var selectedExercise = "Squat"
    @State private var selectedFocus = "Strength-Speed"
    
    let exercises = ["Squat", "Deadlift", "Bench Press"]
    let trainingFocuses = ["Max Strength", "Strength-Speed", "Speed-Strength", "Explosiveness"]
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Velocity-Based Training")
                .font(.largeTitle)
                .bold()
            
            // Exercise Picker
            Picker("Exercise", selection: $selectedExercise) {
                ForEach(exercises, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            // Focus Picker
            Picker("Training Focus", selection: $selectedFocus) {
                ForEach(trainingFocuses, id: \.self) {
                    Text($0)
                }
            }.pickerStyle(MenuPickerStyle())
            
            // Target Range Display
            Text("Target Velocity: \(ThresholdChecker.getTargetRangeText(for: selectedFocus))")
                .font(.headline)
                .padding()
            
            // Live Velocity
            Text("Live Velocity: \(String(format: "%.2f", motion.verticalVelocity)) m/s")
                .font(.title2)
                .foregroundColor(ThresholdChecker.isWithinTarget(for: selectedFocus, velocity: motion.verticalVelocity) ? .green : .red)
                .padding()
            
            // Manual Reset Button
            Button("Reset Velocity") {
                motion.resetVelocity()
            }
            .padding()
            .background(Color.blue.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
