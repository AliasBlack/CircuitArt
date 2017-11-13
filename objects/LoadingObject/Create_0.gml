// Declare global vars.
global.instructions = ds_list_create();

// Add some test instructions.
ds_list_add(global.instructions, "draw_line;0,0,40,40");
ds_list_add(global.instructions, "draw_line;40,40,20,0");

// Goto program proper.
room_goto_next();