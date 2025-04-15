# Simplified velocity estimation pseudocode

prev_time = current_time()
velocity = 0

while True:
    acceleration = get_accelerometer_data()  # in m/s²
    current = current_time()
    dt = current - prev_time
    
    velocity += acceleration * dt
    prev_time = current
    
    if velocity < threshold:
        beep()
        show_alert("Stop set!")
