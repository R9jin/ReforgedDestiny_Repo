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

// --- Enter dash state ---
if (!in_attack && !is_charging && dash_cooldown <= 0 && keyboard_check_pressed(vk_shift)) {
    enter_state(PLAYERSTATE.DASH);
}

// --- Enter roll state ---
if (!in_attack && !is_charging && roll_cooldown <= 0 && keyboard_check_pressed(vk_control)) {
    if (place_meeting(x, y + 1, tilemap)) { // only roll if on ground
        enter_state(PLAYERSTATE.ROLL);
    }
}


// --- Physics & Movement ---
playerPhysics(); // handles vspeed, hspeed, gravity, collisions, etc.

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
    case PLAYERSTATE.DASH:
        playerStateDash(); // <-- now all dash behavior handled here
        break;
	case PLAYERSTATE.ROLL:
		playerStateRoll();
		break;
}

// --- Increment state time
state_time++;

// --- Decrease charge cooldown
if (charge_cooldown > 0) charge_cooldown--;

// --- Debug

