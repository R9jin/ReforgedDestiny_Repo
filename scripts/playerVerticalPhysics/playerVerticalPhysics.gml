function playerVerticalPhysics() {
    // Jump
    if (jump_request && place_meeting(x, y + 1, tilemap)) {
        vertical_velocity = -jump_speed;
        jump_request = false;
    }

    // Gravity
    if (vertical_velocity < 0) {
        vertical_velocity += grav * 0.7; // weaker gravity when going up
    } else {
        vertical_velocity += air_attack_gravity ? grav * 0.2 : grav;
    }

    // Vertical collision
    if (place_meeting(x, y + vertical_velocity, tilemap)) {
        while (!place_meeting(x, y + sign(vertical_velocity), tilemap)) {
            y += sign(vertical_velocity);
        }
        vertical_velocity = 0;
    }
    y += vertical_velocity;

    // Reset air attack gravity when landing
    if (place_meeting(x, y + 1, tilemap)) {
        air_attack_gravity = false;
    }

    // Check if player is on ground
    var on_ground = place_meeting(x, y + 1, tilemap);

    // Landing sound
    if (on_ground && was_in_air) {
        audio_play_sound(landing_sound, 1, false);
    }

    // Update in-air state
    was_in_air = !on_ground;
}
