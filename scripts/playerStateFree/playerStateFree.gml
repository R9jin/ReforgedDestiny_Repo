function playerStateFree() {
    // Decide facing
    if (hor_direction < 0) idleFacing = -1;
    else if (hor_direction > 0) idleFacing = 1;

    // Jump input
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
        jump_request = true;
    }

    // Sprites
	if (!place_meeting(x, y + 1, tilemap)) {
		var jump_sprite = (idleFacing == 1) ? sPlayerJumpingRight : sPlayerJumpingLeft;
		if (sprite_index != jump_sprite) {
			sprite_index = jump_sprite;
			image_index = 0; // start from first frame
			image_speed = 0.5; // stop automatic animation
		}
	} else if (hor_direction == 0) {
		// Idle on ground
		if (sprite_index != (idleFacing == 1 ? sPlyrIdleRight : sPlyrIdleLeft)) {
			sprite_index = (idleFacing == 1) ? sPlyrIdleRight : sPlyrIdleLeft;
		}
	} else {
		// Running on ground
		if (sprite_index != (idleFacing == 1 ? sPlyrRunningRight : sPlyrRunningLeft)) {
			sprite_index = (idleFacing == 1) ? sPlyrRunningRight : sPlyrRunningLeft;
		}
	}
	
	if (key_attack) {
		enter_state(PLAYERSTATE.LAND_ATTACK_1); // use the same land attack
		if (!place_meeting(x, y + 1, tilemap)) {
			air_attack_gravity = true; // slow down gravity mid-air
		}
		return;
	}

}
