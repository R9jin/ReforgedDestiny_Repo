/// --- Step Event: oPlayer ---

// --- Horizontal movement input (arrows + WASD)
hor_direction = (keyboard_check(vk_right) || keyboard_check(ord("D"))) 
              - (keyboard_check(vk_left)  || keyboard_check(ord("A")));

// --- Normal attack key
key_attack = keyboard_check_pressed(ord("K"));

// --- Check if in any attack state
var in_attack = (
    state == PLAYERSTATE.LAND_ATTACK_1 ||
    state == PLAYERSTATE.LAND_ATTACK_2 ||
    state == PLAYERSTATE.LAND_ATTACK_3 ||
    state == PLAYERSTATE.LAND_COMBO ||
    state == PLAYERSTATE.CHARGED_ATTACK
);

// --- Weapon switch input (only if not attacking/charging)
if (!in_attack && !is_charging && keyboard_check_pressed(ord("L"))) {
    current_weapon_index++;
    if (current_weapon_index >= array_length(weapons)) current_weapon_index = 0;
    current_weapon = weapons[current_weapon_index];
}

// --- Enter charged attack state ---
if (!in_attack && charge_cooldown <= 0 && keyboard_check_pressed(ord("J"))) {
    enter_state(PLAYERSTATE.CHARGED_ATTACK);
}

// --- Dash input ---
if (!in_attack && !is_charging && dash_cooldown <= 0 && keyboard_check_pressed(vk_shift)) {
    is_dashing = true;
    dash_timer = dash_time;
    dash_dir = hor_direction != 0 ? hor_direction : idleFacing;
    dash_cooldown = dash_cooldown_max;
}

// --- Apply dash ---
if (is_dashing) {
    hspeed = dash_dir * dash_speed;
    dash_timer--;
    if (dash_timer <= 0) is_dashing = false;
} else {
    // --- Physics & Movement ---
    playerPhysics(); // handles vspeed, hspeed, gravity, collisions, etc.
}

// --- Decrease dash cooldown ---
if (dash_cooldown > 0) dash_cooldown--;

// --- State machine ---
switch(state) {
    case PLAYERSTATE.FREE: 
        playerStateFree();
        break;
    case PLAYERSTATE.LAND_ATTACK_1:
        playerStateLandAtk1();
        break;
    case PLAYERSTATE.LAND_ATTACK_2:
        playerStateLandAtk2();
        break;
    case PLAYERSTATE.LAND_ATTACK_3:
        playerStateLandAtk3();
        break;
    case PLAYERSTATE.CHARGED_ATTACK:
        playerStateChargedAttack();
        break;
}

// --- Increment state time
state_time++;

// --- Decrease charge cooldown
if (charge_cooldown > 0) charge_cooldown--;

// --- Debug
show_debug_message("state=" + string(state) + 
    " | state_time=" + string(state_time) + 
    " | is_charging=" + string(is_charging) + 
    " | charge_time=" + string(charge_time) + 
    " | current_weapon=" + string(current_weapon) + 
    " | sprite=" + sprite_get_name(sprite_index) + 
    " | charge_cooldown=" + string(charge_cooldown) + 
    " | dash_timer=" + string(dash_timer) + 
    " | is_dashing=" + string(is_dashing));
