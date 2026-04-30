/// --- Skeleton: Create Event ---

// --- Movement / Physics ---
hsp = 0;
vsp = 0;
move_speed = 2;
grav = 0.5;
tilemap = layer_tilemap_get_id("collidable");

// --- AI Variables ---
state = "idle";
player_inst = noone;
chase_range = 200;
attack_range = 80;
attack_cooldown = 0;
attack_cooldown_max = 90;

// --- Direction / Facing ---
move_dir = 0;
image_xscale = 1;

// --- State Machine Enum (like player’s) ---
enum ENEMYSTATE {
    IDLE,
    WALK,
    ATTACK
}
state = ENEMYSTATE.IDLE;
state_time = 0;
max_fall_speed = 10; // prevents falling too fast
base_scale = image_xscale; // remember the original scale (usually 1)
