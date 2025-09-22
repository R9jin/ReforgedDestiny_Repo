function playerStateLandAtk2() {
    if (state_time <= 1) {
        image_xscale = (idleFacing == -1) ? -1 : 1;

        switch (current_weapon) {
            case "wood":      sprite_index = sAtkLand2WoodRight; audio_play_sound(landAttack_wood, 0, false); break;
            case "fire":      sprite_index = sAtkLand2FireRight; audio_play_sound(landAttack_fire, 0, false); break;
            case "iron":      sprite_index = sAtkLand2IronRight; audio_play_sound(landAttack_iron, 0, false); break;
			case "water":     sprite_index = sAtkLand2WaterRight; audio_play_sound(landAttack_water, 0, false); break;
			case "wind":	  sprite_index = sAtkLand2WindRight; audio_play_sound(landAttack_wind, 0, false); break;
            case "dark":      sprite_index = sAtkLand2DarkRight; audio_play_sound(landAttack_dark, 0, false); break;
            case "legendary": sprite_index = sAtkLand2LegendRight; audio_play_sound(landAttack_legend, 0, false); break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 2;
        combo_window = room_speed;
    }

    horizontal_velocity = 0;

    if (combo_window > 0) {
        if (keyboard_check_pressed(ord("K"))) {
            combo_queued = true;
        }
        combo_window--;
    }

    if (image_index >= image_number - 1) {
        if (combo_queued) {
            enter_state(PLAYERSTATE.LAND_ATTACK_3);
            combo_queued = false;
        } else {
            enter_state(PLAYERSTATE.FREE);
            attack_step = 0;
        }
    }
}