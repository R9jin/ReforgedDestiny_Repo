function playerStateLandAtk2() {
    if (state_time <= 1) {
        switch (current_weapon) {
            case "wood":
                sprite_index = (idleFacing == -1) ? sAtkLand2WoodLeft : sAtkLand2WoodRight;
                audio_play_sound(landAttack_wood, 0, false);
                break;
            case "fire":
                sprite_index = (idleFacing == -1) ? sAtkLand2FireLeft : sAtkLand2FireRight;
                audio_play_sound(landAttack_fire, 0, false);
                break;
            case "water":
                sprite_index = (idleFacing == -1) ? sAtkLand2WaterLeft : sAtkLand2WaterRight;
                audio_play_sound(landAttack_water, 0, false);
                break;
			case "dark":
                sprite_index = (idleFacing == -1) ? sAtkLand2DarkLeft : sAtkLand2DarkRight;
                audio_play_sound(landAttack_dark, 0, false);
                break;
			case "legendary":
				sprite_index = (idleFacing == -1) ? sAtkLand2LegendLeft : sAtkLand2LegendRight;
				audio_play_sound(landAttack_legend, 0, false);
				break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 2;
        combo_window = room_speed;
    }

    horizontal_velocity = 0;

    // Inside your attack state
	if (combo_window > 0) {
		if (keyboard_check_pressed(ord("K"))) {
			combo_queued = true; // store input
		}
		combo_window--;
	}

	// --- End attack ---
	if (image_index >= image_number - 1) {
		if (combo_queued) {
			enter_state(PLAYERSTATE.LAND_ATTACK_3); // or next attack
			combo_queued = false;
		} else {
			enter_state(PLAYERSTATE.FREE);
			attack_step = 0;
		}
	}
}