function playerStateDash() {
    // --- Enter dash setup ---
    if (state_time <= 1) {
        // Decide dash direction (use input, fallback to facing)
        if (hor_direction != 0) {
			dash_dir = hor_direction; // normal input dash
		} else {
			dash_dir = -idleFacing;   // dash opposite the facing direction
		}


        // Apply dash velocity
        hspeed = dash_dir * dash_speed;

        // Set dash timer
        dash_timer = dash_time;

        // Start cooldown so player can’t spam dash
        dash_cooldown = dash_cooldown_max;

        // Play dash animation (flip with xscale)
        image_xscale = (dash_dir == -1) ? -1 : 1;
        sprite_index = sPlayerDashRight;
        image_index = 0;
        image_speed = 0.2;

        // Optional: play dash sound
        audio_play_sound(snd_dash, 0.5, false);
    }

    // --- During dash ---
    dash_timer--;

    // Cancel vertical velocity if on ground (no hopping while dashing)
    if (place_meeting(x, y + 1, tilemap)) {
        vspeed = 0;
    }

    // --- End dash ---
    if (dash_timer <= 0) {
        hspeed = 0;
        enter_state(PLAYERSTATE.FREE);
    }
}
