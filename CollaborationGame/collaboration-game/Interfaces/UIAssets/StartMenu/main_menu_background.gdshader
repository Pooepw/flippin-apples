shader_type canvas_item;

void vertex() {
	UV.x += TIME * 0.6;
	UV.y += TIME * 0.7;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
