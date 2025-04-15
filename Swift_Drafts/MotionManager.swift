import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private var motionManager = CMMotionManager()
    private var updateInterval = 1.0 / 60.0 // 60 Hz update rate
    
    @Published var verticalVelocity: Double = 0.0
    
    private var previousAcceleration: Double = 0.0
    private var previousTime: Date = Date()

    init() {
        startAccelerometerUpdates()
    }

    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = updateInterval
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
                if let accelData = data {
                    // Use the y-axis (vertical movement when phone is upright)
                    let currentAcceleration = accelData.acceleration.y
                    
                    let currentTime = Date()
                    let deltaTime = currentTime.timeIntervalSince(self.previousTime)
                    
                    // Estimate velocity = ∫acceleration over time
                    let deltaVelocity = currentAcceleration * deltaTime
                    self.verticalVelocity += deltaVelocity
                    
                    // Clip to 2 decimal places
                    self.verticalVelocity = Double(round(100 * self.verticalVelocity) / 100)
                    
                    self.previousTime = currentTime
                    self.previousAcceleration = currentAcceleration
                }
            }
        }
    }
    
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
    
    func resetVelocity() {
        verticalVelocity = 0.0
    }
}
