// Declare global vars.
global.instructions = ds_list_create();

// Add some test instructions.
ds_list_add(global.instructions, "draw_line;200,200,400,400");
ds_list_add(global.instructions, "draw_line;400,400,200,400");

// Goto program proper.
room_goto_next();