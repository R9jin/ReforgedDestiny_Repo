function playerStateLandAtk1() {
    // --- Enter attack once ---
    if (state_time <= 1) {
        switch (current_weapon) {
            case "wood":
                sprite_index = (idleFacing == -1) ? sAtkLand1WoodLeft : sAtkLand1WoodRight;
                audio_play_sound(landAttack_wood, 0, false);
                break;
            case "fire":
                sprite_index = (idleFacing == -1) ? sAtkLand1FireLeft : sAtkLand1FireRight;
                audio_play_sound(landAttack_fire, 0, false);
                break;
            case "water":
                sprite_index = (idleFacing == -1) ? sAtkLand1WaterLeft : sAtkLand1WaterRight;
                audio_play_sound(landAttack_water, 0, false);
                break;
			case "dark":
				sprite_index = (idleFacing == -1) ? sAtkLand1DarkLeft : sAtkLand1DarkRight;
				audio_play_sound(landAttack_dark, 0, false);
				break;
			case "legendary":
				sprite_index = (idleFacing == -1) ? sAtkLand1LegendLeft : sAtkLand1LegendRight;
				audio_play_sound(landAttack_legend, 0, false);
				break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 1;
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
			enter_state(PLAYERSTATE.LAND_ATTACK_2); // or next attack
			combo_queued = false;
		} else {
			enter_state(PLAYERSTATE.FREE);
			attack_step = 0;
		}
	}
}