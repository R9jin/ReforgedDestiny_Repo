/// --- Movement / Physics ---
horizontal_velocity = 0;
vertical_velocity   = 0;
move_speed          = 8;
grav                = 0.9;
jump_speed          = 17;
tilemap             = layer_tilemap_get_id("collidable");

/// --- Direction / Facing ---
hor_direction = 0;
idleFacing    = 1;

/// --- Input flags ---
key_attack   = false;
jump_request = false;

/// --- State Machine ---
enum PLAYERSTATE {
    FREE,
    LAND_ATTACK_1,
    LAND_ATTACK_2,
    LAND_ATTACK_3,
    CHARGED_ATTACK,
    DASH,
    ROLL
}
state      = PLAYERSTATE.FREE;
state_time = 0;

/// --- Player Weapons ---
weapons               = ["wood", "iron", "fire", "water", "wind", "dark", "legendary"]; 
current_weapon_index  = 0;
current_weapon        = weapons[current_weapon_index];

/// --- Attack / Combo Logic ---
attack_step   = 0;
combo_window  = 0;
combo_queued  = false;

/// --- Charge / Heavy Attack Flags ---
charge_time        = 0;
max_charge         = 90;   // frames to full charge
is_charging        = false;
heavy_attack_started = false; 
charge_cooldown    = 0;
charge_cooldown_max= 500; 
played_heavy_sound = false;

/// --- Sprites ---
sPlyrIdleRight     = sPlayerIdleRight;
sPlyrRunningRight  = sPlayerRunningRight;
sPlyrJumpingRight  = sPlayerJumpingRight;
sPlyrRunEndRight   = sPlayerRunEndRight;
sPlyrDashRight     = sPlayerDashRight;
sPlyrAirDashRight  = sPlayerAirDashRight;
sPlyrRoll          = sPlayerRoll; // <- make sure this exists

/// --- Other flags ---
air_attack_gravity = false;
was_in_air         = false;
hitByAttack        = ds_list_create();

/// --- Dash Settings ---
dash_speed        = 8;
dash_time         = 10;
dash_cooldown_max = 30;
dash_timer        = 0;
dash_cooldown     = 0;
dash_dir          = 0;
is_dashing        = false;

/// --- Roll Settings ---
roll_speed        = 4;   // slower than dash
roll_time         = 10;  // lasts a bit longer
roll_cooldown_max = 0; // can’t spam roll
roll_timer        = 0;
roll_cooldown     = 0;
roll_dir          = 0;
is_rolling        = false;

/// --- Jump ---
jump_max   = 2; // 1 = single jump, 2 = double jump
jump_count = 0;

was_running = false;
