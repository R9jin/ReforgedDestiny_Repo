function playerStateFree() {
    // Decide facing
    if (hor_direction < 0) idleFacing = -1;
    else if (hor_direction > 0) idleFacing = 1;
    image_xscale = (idleFacing == -1) ? -1 : 1;

    // Jump input
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        jump_request = true;
    }

    // Attack input (highest priority)
    if (key_attack) {
        enter_state(PLAYERSTATE.LAND_ATTACK_1);
        if (!place_meeting(x, y + 1, tilemap)) {
            air_attack_gravity = true;
        }
        return;
    }

    // Air check (jump/fall)
    if (!place_meeting(x, y + 1, tilemap)) {
        if (sprite_index != sPlyrJumpingRight) {
            sprite_index = sPlyrJumpingRight;
            image_index = 0;
            image_speed = 0.5;
        }
        was_running = false; // reset running flag while in air
        return; // skip running/end-run/idle
    }

    // Running
    if (hor_direction != 0) {
        if (sprite_index != sPlyrRunningRight) {
            sprite_index = sPlyrRunningRight;
            image_index = 0;
            image_speed = 0.5;
        }
        was_running = true;
    }
    // End-run (player just stopped)
    else if (hor_direction == 0 && was_running) {
        if (sprite_index != sPlyrRunEndRight) {
            sprite_index = sPlyrRunEndRight;
            image_index = 0;
            image_speed = 0.5;
        }
        // When end-run finishes, switch to idle
        if (sprite_index == sPlyrRunEndRight && image_index >= sprite_get_number(sPlyrRunEndRight) - 1) {
            sprite_index = sPlyrIdleRight;
            was_running = false;
        }
    }
    // Idle
    else if (hor_direction == 0) {
        if (sprite_index != sPlyrIdleRight) {
            sprite_index = sPlyrIdleRight;
        }
    }
}
