if (variable_instance_exists(other.id, "hp")) {
    other.hp -= damage;

    if (variable_instance_exists(other.id, "hsp")) {
        other.hsp = sign(other.x - x) * 3; // knockback
    }

    show_debug_message("Hit skeleton! Remaining HP: " + string(other.hp));
}
