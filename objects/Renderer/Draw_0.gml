// Render grid.
draw_set_alpha(0.3);
draw_set_color(c_white);
for (gridX = 0; gridX < room_width; gridX += currentUnit) {
	for (gridY = 0; gridY < room_height; gridY += currentUnit) {
		draw_point(xAdjust(gridX), yAdjust(gridY));
	}
}

// Render marker.
markerx = round(((mouse_x - currentXOffset) / currentScale) / currentUnit) * currentUnit;
markery = round(((mouse_y - currentYOffset) / currentScale) / currentUnit) * currentUnit;
if keyboard_check(vk_shift) and ds_list_size(tempArguments) > 1 {
	xy = (abs(mouse_x - ds_list_find_value(tempArguments, ds_list_size(tempArguments) - 2)) < abs(mouse_y - ds_list_find_value(tempArguments, ds_list_size(tempArguments) - 1))) ? true : false;
	markerx = (xy) ? ds_list_find_value(tempArguments, ds_list_size(tempArguments) - 2) : markerx;
	markery = (xy) ? markery : ds_list_find_value(tempArguments, ds_list_size(tempArguments) - 1);
}
draw_circle (xAdjust(markerx), yAdjust(markery), 20 * currentScale, true);

// Draw mirror.
if mirror > 0 {
	draw_set_color(c_white);
	draw_set_alpha(0.5);
	draw_line(xAdjust(mirror), yAdjust(0), xAdjust(mirror), yAdjust(room_height));
}

// Render drawing.
for (ind = 0; ind < ds_list_size(global.instructions); ind++) {
	temp = split(ds_list_find_value(global.instructions, ind), ";");
	arguments = splitReal(temp[1], ",");
	switch (temp[0]) {
		
		case "draw_line":
			draw_set_color(arguments[0]);
			draw_set_alpha(arguments[1]/100);
			draw_line (
				xAdjust(arguments[2]),
				yAdjust(arguments[3]),
				xAdjust(arguments[4]),
				yAdjust(arguments[5])
			);
		break;
			
		case "draw_polygon":
			draw_set_color(arguments[0]);
			draw_primitive_begin(pr_trianglestrip);
			vertexRev = array_length_1d(arguments) - 2;
			for (pr = 2; pr < array_length_1d(arguments); pr += 2) {
				draw_set_alpha(arguments[1]/400);
				if (pr < vertexRev) {
					draw_vertex(xAdjust(arguments[pr]), yAdjust(arguments[pr + 1]));
					draw_vertex(xAdjust(arguments[vertexRev]), yAdjust(arguments[vertexRev + 1]));
					vertexRev -= 2;
				} else if (pr == vertexRev) {
					draw_vertex(xAdjust(arguments[pr]), yAdjust(arguments[pr + 1]));
				}
				if (pr > 3) {
					draw_set_alpha(arguments[1]/100);
					draw_line_glow(arguments[pr - 2], arguments[pr - 1], arguments[pr], arguments[pr + 1]);
				}
			}
			draw_line_glow (
				arguments[2],
				arguments[3],
				arguments[array_length_1d(arguments) - 2],
				arguments[array_length_1d(arguments) - 1]
			);
			draw_primitive_end();
		break;
		
		case "draw_triangleStrip":
			draw_set_color(arguments[0]);
			draw_primitive_begin(pr_trianglestrip);
			for (pr = 2; pr < array_length_1d(arguments); pr += 2) {
				draw_set_alpha(arguments[1]/400);
				draw_vertex(xAdjust(arguments[pr]), yAdjust(arguments[pr + 1]));
				if (pr > 5) {
					draw_set_alpha(arguments[1]/100);
					draw_line_glow(arguments[pr - 4], arguments[pr - 3], arguments[pr], arguments[pr + 1]);
				}
			}
			draw_primitive_end();
		break;
	}
}

// Draw brushes in progress.
switch global.currentBrush {
	
	// If polygon tool is selected.
	case brush.polygon:
		if (ds_list_size(tempArguments) > 1) {
			draw_set_color(tempColor);
			
			// If mirror and mirror joining is turned on.
			if (mirror > 0 and mirrorJoined) {
				draw_primitive_begin(pr_trianglestrip);
				draw_set_alpha(tempAlpha/400);
				for (pr = 0; pr < ds_list_size(tempArguments); pr += 2) {					
					draw_vertex (
						xAdjust(ds_list_find_value(tempArguments, pr)),
						yAdjust(ds_list_find_value(tempArguments, pr + 1))
					);
					draw_vertex (
						xAdjust(mir(ds_list_find_value(tempArguments, pr))),
						yAdjust(ds_list_find_value(tempArguments, pr + 1))
					);
				}
				draw_vertex(xAdjust(markerx), yAdjust(markery));
				draw_vertex(xAdjust(mir(markerx)), yAdjust(markery));
				draw_primitive_end();
				
			// Else, draw normally.
			} else {
				draw_primitive_begin(pr_trianglestrip);
				draw_set_alpha(tempAlpha/400);
				draw_vertex (
					xAdjust(ds_list_find_value(tempArguments, 0)),
					yAdjust(ds_list_find_value(tempArguments, 1))
				);
				draw_vertex (xAdjust(markerx), yAdjust(markery));
				vertexRev = ds_list_size(tempArguments) - 2;
				for (pr = 2; pr < ds_list_size(tempArguments); pr += 2) {
					draw_set_alpha(tempAlpha/400);
					if (pr < vertexRev) {
						draw_vertex (
							xAdjust(ds_list_find_value(tempArguments, pr)),
							yAdjust(ds_list_find_value(tempArguments, pr + 1))
						);
						draw_vertex (
							xAdjust(ds_list_find_value(tempArguments, vertexRev)),
							yAdjust(ds_list_find_value(tempArguments, vertexRev + 1))
						);
						vertexRev -= 2;
					} else if (pr == vertexRev) {
						draw_vertex (
							xAdjust(ds_list_find_value(tempArguments, pr)),
							yAdjust(ds_list_find_value(tempArguments, pr + 1))
						);
					}
				}
				draw_primitive_end();
			
				// If mirror is on, and not joined.
				if (mirror > 0) {
					draw_set_color(tempColor);
					draw_primitive_begin(pr_trianglestrip);
					draw_set_alpha(tempAlpha/400);
					draw_vertex (
						xAdjust(mir(ds_list_find_value(tempArguments, 0))),
						yAdjust(ds_list_find_value(tempArguments, 1))
					);
					draw_vertex (xAdjust(mir(markerx)), yAdjust(markery));
					vertexRev = ds_list_size(tempArguments) - 2;
					for (pr = 2; pr < ds_list_size(tempArguments); pr += 2) {
						draw_set_alpha(tempAlpha/400);
						if (pr < vertexRev) {
							draw_vertex (
								xAdjust(mir(ds_list_find_value(tempArguments, pr))),
								yAdjust(ds_list_find_value(tempArguments, pr + 1))
							);
							draw_vertex (
								xAdjust(mir(ds_list_find_value(tempArguments, vertexRev))),
								yAdjust(ds_list_find_value(tempArguments, vertexRev + 1))
							);
							vertexRev -= 2;
						} else if (pr == vertexRev) {
							draw_vertex (
								xAdjust(mir(ds_list_find_value(tempArguments, pr))),
								yAdjust(ds_list_find_value(tempArguments, pr + 1))
							);
						}
					}
					draw_primitive_end();
				}
			}
		}
	break;
}