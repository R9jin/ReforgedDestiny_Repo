// Speeds for each layer (slowest → fastest)
var speeds = [0.2, 0.5, 1, 2];

// Layer names (match names in your room editor)
var layers = [
    "bg_sky",
    "bg_clouds",
    "bg_hills",
    "bg_hills2",
];

// Scroll + scale layers
for (var i = 0; i < array_length(layers); i++) {
    var layer_id = layer_get_id(layers[i]);               // layer
    var bg_id    = layer_background_get_id(layer_id);     // background element inside

    // --- Scroll background
    var xpos = layer_background_x(bg_id);                 // get background x offset
    layer_background_x(bg_id, xpos - speeds[i]);          // move it left

    // --- Scale background
    layer_background_xscale(bg_id, 2);  // width ×2
    layer_background_yscale(bg_id, 2);  // height ×2
}
