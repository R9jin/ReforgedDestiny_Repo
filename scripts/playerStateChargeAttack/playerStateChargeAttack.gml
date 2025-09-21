function playerStateChargedAttack() {
    // --- Charging phase ---
    if (!heavy_attack_started) {
        if (keyboard_check(ord("J"))) {
            // Start / continue charging
            if (!is_charging) {
                is_charging = true;
                charge_started = false;
                in_initial = false;
                charge_time = 0;
            }

            // Flip sprite (always do this once per step)
            image_xscale = (idleFacing == -1) ? -1 : 1;

            // Initial charge animation
            if (!charge_started) {
                charge_started = true;
                in_initial = true;

                switch (current_weapon) {
                    case "fire":      sprite_index = sInitialChargeFireRight; break;
                    case "wood":      sprite_index = sInitialChargeWoodRight; break;
                    case "water":     sprite_index = sInitialChargeWaterRight; break;
                    case "dark":      sprite_index = sInitialChargeDarkRight; break;
                    case "legendary": sprite_index = sInitialChargeLegendRight; break;
                }

                image_index = 0;
                image_speed = 1.5;
            }

            // Loop charge animation
            if (in_initial && image_index >= image_number - 1) {
                in_initial = false;

                switch (current_weapon) {
                    case "fire":      sprite_index = sChargeLoopFireRight; break;
                    case "wood":      sprite_index = sChargeLoopWoodRight; break;
                    case "water":     sprite_index = sChargeLoopWaterRight; break;
                    case "dark":      sprite_index = sChargeLoopDarkRight; break;
                    case "legendary": sprite_index = sChargeLoopLegendRight; break;
                }

                image_index = 0;
                image_speed = 1;
            }

            // Freeze movement if on ground
			if (place_meeting(x, y + 1, tilemap)) {
				horizontal_velocity = 0;
				hor_direction = 0;	
			}


        } else {
            // --- Key released, start heavy attack ---
            is_charging = false;
            charge_started = false;
            in_initial = false;
            charge_time = 0;
            charge_cooldown = 30;

            heavy_attack_started = true;

            // Flip sprite
            image_xscale = (idleFacing == -1) ? -1 : 1;

            switch (current_weapon) {
                case "wood":      sprite_index = sHeavyAttackWoodRight;  audio_play_sound(heavyAttack_wood,0,false); break;
                case "fire":      sprite_index = sHeavyAttackFireRight;  audio_play_sound(heavyAttack_fire,0,false); break;
                case "water":     sprite_index = sHeavyAttackWaterRight; audio_play_sound(heavyAttack_water,0,false); break;
                case "dark":      sprite_index = sHeavyAttackDarkRight;  audio_play_sound(heavyAttack_dark,0,false); break;
                case "legendary": sprite_index = sHeavyAttackLegendRight; audio_play_sound(heavyAttack_legend,0,false); break;
            }

            image_index = 0;
            image_speed = 1;
        }
    }

    // --- Heavy attack animation running phase ---
    if (heavy_attack_started) {
        // Freeze movement if needed
        if (place_meeting(x, y + 1, tilemap)) {
            hspeed = 0;
            vspeed = 0;
            hor_direction = 0;
        }

        // End attack when sprite finishes
        if (image_index >= image_number - 1) {
            enter_state(PLAYERSTATE.FREE);
            heavy_attack_started = false;
        }
    }
}
