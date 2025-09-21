function playerStateLandAtk3() {
    if (state_time <= 1) {
        switch (current_weapon) {
            case "wood":
                sprite_index = (idleFacing == -1) ? sAtkLand3WoodLeft : sAtkLand3WoodRight;
                audio_play_sound(landAttack_wood, 0, false);
                break;
            case "fire":
                sprite_index = (idleFacing == -1) ? sAtkLand3FireLeft : sAtkLand3FireRight;
                audio_play_sound(landAttack_fire, 0, false);
                break;
            case "water":
                sprite_index = (idleFacing == -1) ? sAtkLand3WaterLeft : sAtkLand3WaterRight;
                audio_play_sound(landAttack_water, 0, false);
                break;
			case "dark":
                sprite_index = (idleFacing == -1) ? sAtkLand3DarkLeft : sAtkLand3DarkRight;
                audio_play_sound(landAttack_dark, 0, false);
                break;
			case "legendary":
				sprite_index = (idleFacing == -1) ? sAtkLand3LegendLeft : sAtkLand3LegendRight;
				audio_play_sound(landAttack_legend, 0, false);
				break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 3;
    }

    horizontal_velocity = 0;

    // No more chaining after 3rd attack
    if (image_index >= image_number - 1) {
        enter_state(PLAYERSTATE.FREE);
        attack_step = 0;
    }
}