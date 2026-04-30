function playerStateLandAtk1() {
    // --- Enter attack once ---
    if (state_time <= 1) {
        // Always flip based on facing
        image_xscale = (idleFacing == -1) ? -1 : 1;

        switch (current_weapon) {
            case "wood":      sprite_index = sAtkLand1WoodRight; audio_play_sound(landAttack_wood, 0, false); break;
            case "fire":      sprite_index = sAtkLand1FireRight; audio_play_sound(landAttack_fire, 0, false); break;
            case "iron":      sprite_index = sAtkLand1IronRight; audio_play_sound(landAttack_iron, 0, false); break;
            case "water":     sprite_index = sAtkLand1WaterRight; audio_play_sound(landAttack_water, 0, false); break;
            case "wind":      sprite_index = sAtkLand1WindRight; audio_play_sound(landAttack_wind, 0, false); break;
            case "dark":      sprite_index = sAtkLand1DarkRight; audio_play_sound(landAttack_dark, 0, false); break;
            case "legendary": sprite_index = sAtkLand1LegendRight; audio_play_sound(landAttack_legend, 0, false); break;
        }

        image_index = 0;
        image_speed = 1;
        attack_step = 1;
        combo_window = room_speed;
        attack_spawned = false; // reset flag
    }

    horizontal_velocity = 0;

    // inside playerStateLandAtk1
if (image_index == 1 && !attack_spawned) {
    var hb_data = attack_hitboxes.land1; // [width, height, offset_x, offset_y]
    
    var hitX = x + (image_xscale * hb_data[2]);
    var hitY = y + hb_data[3];

    var hitbox_inst = instance_create_layer(hitX, hitY, "Instances", oPlayerAttackHitbox);
    hitbox_inst.hitbox_width  = hb_data[0];
    hitbox_inst.hitbox_height = hb_data[1];
    hitbox_inst.damage = 1;
    hitbox_inst.life = 10;  // frames to show for debugging

    attack_spawned = true;

    show_debug_message("Hitbox spawned at x:" + string(hitX) + ", y:" + string(hitY));
} else if (image_index != 1) {
    attack_spawned = false; // reset for next frame
}

    // Combo queue check
    if (combo_window > 0) {
        if (keyboard_check_pressed(ord("K"))) {
            combo_queued = true;
        }
        combo_window--;
    }

    // --- End attack ---
    if (image_index >= image_number - 1) {
        if (combo_queued) {
            enter_state(PLAYERSTATE.LAND_ATTACK_2);
            combo_queued = false;
        } else {
            enter_state(PLAYERSTATE.FREE);
            attack_step = 0;
        }
    }
}
