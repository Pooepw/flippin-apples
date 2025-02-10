shader_type canvas_item;

void vertex() {
	UV.x += TIME * -0.3;
	UV.y += TIME * 0.4;
	COLOR.r += (TIME + 100.0) * 0.001;
	COLOR.g += (TIME + 40.0) * 0.0005;
	COLOR.b += TIME * 0.002;

}
