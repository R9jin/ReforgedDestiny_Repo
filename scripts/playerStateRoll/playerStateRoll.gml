function playerStateRoll() {
    if (state_time <= 1) {
        roll_dir = (hor_direction != 0) ? hor_direction : idleFacing;
        hspeed   = roll_dir * roll_speed;
        roll_timer = roll_time;
        roll_cooldown = roll_cooldown_max;

        sprite_index = sPlyrRoll; // roll animation
        image_index  = 0;
        image_speed  = 1;

        // audio_play_sound(snd_roll, 0.5, false);
    }

    roll_timer--;

    // --- Step-by-step horizontal movement (prevents clipping) ---
    var move = hspeed;
    var step = sign(move);

    repeat(abs(move)) {
        // Check clearance at head level before moving into tile
        if (!place_meeting(x + step, y, tilemap) && !place_meeting(x + step, y - 16, tilemap)) {
            x += step; 
        } else {
            // Blocked -> stop roll
            hspeed = 0;
            enter_state(PLAYERSTATE.FREE);
            break;
        }
    }

    // Gravity (still falls if rolling off ledge)
    playerVerticalPhysics();

    // End roll after timer
    if (roll_timer <= 0) {
        hspeed = 0;
        enter_state(PLAYERSTATE.FREE);
    }
}
