midptx = xAdjust((argument2 + argument0) / 2);
midpty = yAdjust((argument3 + argument1) / 2);
draw_line_color (
	xAdjust(argument0),
	yAdjust(argument1),
	midptx,
	midpty,
	c_white,
	draw_get_color()
);
draw_line_color (
	midptx,
	midpty,
	xAdjust(argument2),
	yAdjust(argument3),
	draw_get_color(),
	c_white
);