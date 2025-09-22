// Find the player instance
var player = instance_find(oPlayer, 0);

// Safety check
if (player == noone || !variable_instance_exists(player, "weapons") || !is_array(player.weapons)) {
    return; // nothing to draw
}

var hud_x = 20;
var hud_y = 20;
var scale = 2; // 2x size
var icon_w = sprite_get_width(sWeaponsHUDFULL) * scale;
var icon_h = sprite_get_height(sWeaponsHUDFULL) * scale;

// Make sure the current weapon index is valid
if (player.current_weapon_index >= 0 && player.current_weapon_index < array_length(player.weapons)) {
    // Draw the sprite frame that corresponds to the equipped weapon, scaled up
    var frame = player.current_weapon_index;
    if (frame >= sprite_get_number(sWeaponsHUDFULL)) frame = 0; // safety check
    
    draw_sprite_ext(sWeaponsHUDFULL, frame, hud_x, hud_y, scale, scale, 0, c_white, 1);

    // Draw weapon name above the icon
    draw_text(hud_x, hud_y - 20, player.weapons[player.current_weapon_index]);
}
