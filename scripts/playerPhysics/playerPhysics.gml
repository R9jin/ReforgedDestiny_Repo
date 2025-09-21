function playerPhysics() {
    // Horizontal input
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

    // Horizontal Collision
    if (place_meeting(x + horizontal_velocity, y, tilemap)) {
        while (!place_meeting(x + sign(horizontal_velocity), y, tilemap)) {
            x += sign(horizontal_velocity);
        }
        horizontal_velocity = 0;
    }
    x += horizontal_velocity;

	// Jump
    if (jump_request && place_meeting(x, y + 1, tilemap)) {
        vertical_velocity = -jump_speed;
		jump_request = false;
    }
	
    // Gravity
	if (vertical_velocity < 0) {
		vertical_velocity += grav * 0.7; // weaker gravity when going up
	} else {
		if (air_attack_gravity) {
			vertical_velocity += grav * 0.2; // slower fall while attacking mid-air
		} else {
			vertical_velocity += grav * 1.0; // normal fall
		}
	}


    

    // Vertical Collision
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

	// Play landing sound only when player just touches the ground
	if (on_ground && was_in_air) {
		audio_play_sound(landing_sound, 1, false); // play once
	}

	// Update the in-air state for next step
	was_in_air = !on_ground;

	
}
