// dimensions & damage
hitbox_width  = 136;  // example, set dynamically when spawning
hitbox_height = 65;
damage = 1;

// life of hitbox (optional)
life = 10;  // frames to show
// just initialize if needed
if (!variable_instance_exists(id, "life")) life = 10;