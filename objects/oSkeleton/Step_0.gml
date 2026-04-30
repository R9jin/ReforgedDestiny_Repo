/// --- Find nearest player ---
player_inst = instance_nearest(x, y, oPlayer);

/// --- Handle cooldowns ---
if (attack_cooldown > 0) attack_cooldown--;

var prev_state = state; // for resetting state_time
var dist = 9999;
if (player_inst != noone) dist = point_distance(x, y, player_inst.x, player_inst.y);

/// --- AI logic ---
switch (state) {
    case ENEMYSTATE.IDLE:
        sprite_index = sSkeletonIdle;
        image_speed = 1;
        move_dir = 0;

        if (dist < chase_range) state = ENEMYSTATE.WALK;
        break;

    case ENEMYSTATE.WALK:
        sprite_index = sSkeletonWalk;
        image_speed = 1;

        if (dist > chase_range) {
            state = ENEMYSTATE.IDLE;
        } else if (dist <= attack_range && attack_cooldown <= 0) {
            state = ENEMYSTATE.ATTACK;
        } else {
            move_dir = sign(player_inst.x - x);
        }
        break;

    case ENEMYSTATE.ATTACK:
        if (state_time == 0) {
            sprite_index = sSkeletonAttack;
            image_index = 0;
            image_speed = 1;
            hsp = 0;
            attack_cooldown = attack_cooldown_max;
        }

        // Deal damage mid-animation (tweak range based on sprite)
        if (image_index >= 2 && image_index <= 3) {
            if (instance_exists(player_inst)) {
                if (point_distance(x, y, player_inst.x, player_inst.y) < attack_range + 10) {
                    with (player_inst) {
                        if (variable_instance_exists(id, "hp")) {
                            hp -= 1; // Example damage
                        }
                    }
                }
            }
        }

        // Return to walking after attack animation finishes
        if (image_index >= image_number - 1) {
            state = ENEMYSTATE.WALK;
        }
        break;
}

// --- Reset state time when switching states ---
if (state != prev_state) state_time = 0;
else state_time++;

// --- Apply movement ---
if (state == ENEMYSTATE.WALK) {
    hsp = move_dir * move_speed;
} else {
    hsp = 0;
}

// --- Flip sprite without breaking per-sprite scaling ---
if (move_dir != 0) {
    var sprite_scale = sprite_get_xoffset(sprite_index) == 0 ? 1 : abs(image_xscale); 
    image_xscale = sprite_scale * move_dir;
}

// --- Apply physics ---
enemyPhysics();
