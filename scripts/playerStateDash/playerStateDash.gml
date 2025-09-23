function playerStateDash() {
    if (state_time <= 1) {
        dash_dir = (hor_direction != 0) ? hor_direction : -idleFacing;
        hspeed   = dash_dir * dash_speed;
        dash_timer = dash_time;
        dash_cooldown = dash_cooldown_max;

        image_xscale = (idleFacing == -1) ? -1 : 1;
        sprite_index = place_meeting(x, y+1, tilemap) ? sPlyrDashRight : sPlyrAirDashRight;
        image_index = 0;
        image_speed = 0.2;
        audio_play_sound(snd_dash, 0.5, false);
    }

    dash_timer--;

    // --- Dash horizontal collision with rollback method ---
var safe_x = x; 
var move = hspeed;

// try move
x += move;

// check collision after moving
if (place_meeting(x, y, tilemap)) {
    // rollback until safe (pixel by pixel)
    while (place_meeting(x, y, tilemap)) {
        x -= sign(move);
    }

    // optionally: pull back an extra pixel to avoid "sticky" feeling
    if (!place_meeting(x - sign(move), y, tilemap)) {
        x -= sign(move);
    }

    hspeed = 0;
    enter_state(PLAYERSTATE.FREE);
}


    // --- Vertical physics (gravity, jump, etc.)
    playerVerticalPhysics();

    if (dash_timer <= 0) {
        hspeed = 0;
        enter_state(PLAYERSTATE.FREE);
    }
}
