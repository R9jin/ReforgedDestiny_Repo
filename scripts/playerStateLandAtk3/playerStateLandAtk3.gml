function playerStateLandAtk3() {
    if (state_time <= 1) {
        image_xscale = (idleFacing == -1) ? -1 : 1;

        switch (current_weapon) {
            case "wood":      sprite_index = sAtkLand3WoodRight; audio_play_sound(landAttack_wood, 0, false); break;
            case "fire":      sprite_index = sAtkLand3FireRight; audio_play_sound(landAttack_fire, 0, false); break;
            case "water":     sprite_index = sAtkLand3WaterRight; audio_play_sound(landAttack_water, 0, false); break;
            case "dark":      sprite_index = sAtkLand3DarkRight; audio_play_sound(landAttack_dark, 0, false); break;
            case "legendary": sprite_index = sAtkLand3LegendRight; audio_play_sound(landAttack_legend, 0, false); break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 3;
    }

    horizontal_velocity = 0;

    // End attack (no chaining after 3rd)
    if (image_index >= image_number - 1) {
        enter_state(PLAYERSTATE.FREE);
        attack_step = 0;
    }
}