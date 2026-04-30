function enemyPhysics() {
    // --- Gravity ---
    vsp += grav;
    if (vsp > max_fall_speed) vsp = max_fall_speed;

    // --- Horizontal movement ---
    hsp = move_dir * move_speed;

    // --- Collisions with the tilemap ---
    if (place_meeting(x + hsp, y, tilemap)) {
        while (!place_meeting(x + sign(hsp), y, tilemap)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;

    // --- Vertical movement ---
    if (place_meeting(x, y + vsp, tilemap)) {
        while (!place_meeting(x, y + sign(vsp), tilemap)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
	
	
}
