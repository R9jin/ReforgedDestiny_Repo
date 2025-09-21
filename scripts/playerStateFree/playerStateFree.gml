function playerStateFree() {
    // Decide facing
    if (hor_direction < 0) idleFacing = -1;
    else if (hor_direction > 0) idleFacing = 1;

    // Flip sprite
    image_xscale = (idleFacing == -1) ? -1 : 1;

    // Jump input
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        jump_request = true;
    }

    // Sprites
    if (!place_meeting(x, y + 1, tilemap)) {
        // Jumping
        if (sprite_index != sPlayerJumpingRight) {
            sprite_index = sPlayerJumpingRight;
            image_index = 0;
            image_speed = 0.5;
        }
    } else if (hor_direction == 0) {
        // Idle
        if (sprite_index != sPlyrIdleRight) {
            sprite_index = sPlyrIdleRight;
        }
    } else {
        // Running
        if (sprite_index != sPlyrRunningRight) {
            sprite_index = sPlyrRunningRight;
        }
    }

    // Attack input
    if (key_attack) {
        enter_state(PLAYERSTATE.LAND_ATTACK_1);
        if (!place_meeting(x, y + 1, tilemap)) {
            air_attack_gravity = true;
        }
        return;
    }
}
