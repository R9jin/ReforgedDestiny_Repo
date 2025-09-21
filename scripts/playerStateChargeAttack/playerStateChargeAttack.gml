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

            // Initial charge animation
            if (!charge_started) {
                charge_started = true;
                in_initial = true;

                switch (current_weapon) {
                    case "fire":      sprite_index = (idleFacing == -1) ? sInitialChargeFireLeft  : sInitialChargeFireRight; break;
                    case "wood":      sprite_index = (idleFacing == -1) ? sInitialChargeWoodLeft  : sInitialChargeWoodRight; break;
                    case "water":     sprite_index = (idleFacing == -1) ? sInitialChargeWaterLeft : sInitialChargeWaterRight; break;
                    case "dark":      sprite_index = (idleFacing == -1) ? sInitialChargeDarkLeft  : sInitialChargeDarkRight; break;
                    case "legendary": sprite_index = (idleFacing == -1) ? sInitialChargeLegendLeft : sInitialChargeLegendRight; break;
                }

                image_index = 0;
                image_speed = 1.5;
            }

            // Loop charge animation
            if (in_initial && image_index >= image_number - 1) {
                in_initial = false;

                switch (current_weapon) {
                    case "fire":      sprite_index = (idleFacing == -1) ? sChargeLoopFireLeft  : sChargeLoopFireRight; break;
                    case "wood":      sprite_index = (idleFacing == -1) ? sChargeLoopWoodLeft  : sChargeLoopWoodRight; break;
                    case "water":     sprite_index = (idleFacing == -1) ? sChargeLoopWaterLeft : sChargeLoopWaterRight; break;
                    case "dark":      sprite_index = (idleFacing == -1) ? sChargeLoopDarkLeft  : sChargeLoopDarkRight; break;
                    case "legendary": sprite_index = (idleFacing == -1) ? sChargeLoopLegendLeft : sChargeLoopLegendRight; break;
                }

                image_index = 0;
                image_speed = 1;
            }

            // Freeze movement if on ground
            if (place_meeting(x, y + 1, tilemap)) {
                hspeed = 0;
                vspeed = 0;
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

            switch (current_weapon) {
                case "wood":      sprite_index = (idleFacing == -1) ? sHeavyAttackWoodLeft : sHeavyAttackWoodRight; audio_play_sound(heavyAttack_wood,0,false); break;
                case "fire":      sprite_index = (idleFacing == -1) ? sHeavyAttackFireLeft : sHeavyAttackFireRight; audio_play_sound(heavyAttack_fire,0,false); break;
                case "water":     sprite_index = (idleFacing == -1) ? sHeavyAttackWaterLeft : sHeavyAttackWaterRight; audio_play_sound(heavyAttack_water,0,false); break;
                case "dark":      sprite_index = (idleFacing == -1) ? sHeavyAttackDarkLeft : sHeavyAttackDarkRight; audio_play_sound(heavyAttack_dark,0,false); break;
                case "legendary": sprite_index = (idleFacing == -1) ? sHeavyAttackLegendLeft : sHeavyAttackLegendRight; audio_play_sound(heavyAttack_legend,0,false); break;
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
