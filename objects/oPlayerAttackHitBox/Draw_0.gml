draw_set_alpha(0.3);
draw_set_color(c_red);
draw_rectangle(
    x - hitbox_width/2, y - hitbox_height/2,
    x + hitbox_width/2, y + hitbox_height/2,
    true
);
draw_set_alpha(1);
