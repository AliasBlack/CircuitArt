// Declare global vars.
global.instructions = ds_list_create();
global.currentBrush = brush.polygon;

// Add some test instructions.
//ds_list_add(global.instructions, "draw_polygon;255,100,100,80,200,200,400,400,200,400,200,200");

// Brush enum.
enum brush {
	none,
	line,
	polygon,
	circle
}

// Goto program proper.
room_goto_next();