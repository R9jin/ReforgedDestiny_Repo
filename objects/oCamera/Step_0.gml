if (follow != noone) {
    xTo = follow.x + (lookaheadDist * follow.idleFacing);
    yTo = follow.y;
}

// Smooth camera follow
// in max speed
if(follow.move_speed == abs(follow.horizontal_velocity)){
	x += (xTo - x) / 19;
	y += (yTo - y) / 19;
}else{
	x += (xTo - x) / 25;
	y += (yTo - y) / 25;
	
}


// Apply camera position
camera_set_view_pos(view_camera[0], x - (cam_width * 0.5), y - (cam_height * 0.5));
