function playerPhysics() {
    // --- Horizontal input ---
    var accel = 2;
    if (hor_direction != 0) {
        horizontal_velocity += hor_direction * accel;
        horizontal_velocity = clamp(horizontal_velocity, -move_speed, move_speed);
    } else {
        // Friction
        if (abs(horizontal_velocity) < accel) {
            horizontal_velocity = 0;
        } else {
            horizontal_velocity -= sign(horizontal_velocity) * accel;
        }
    }

    // --- Horizontal collision ---
    if (place_meeting(x + horizontal_velocity, y, tilemap)) {
        while (!place_meeting(x + sign(horizontal_velocity), y, tilemap)) {
            x += sign(horizontal_velocity);
        }
        horizontal_velocity = 0;
    }
    x += horizontal_velocity;

    // --- Vertical physics (shared) ---
    playerVerticalPhysics();
}
