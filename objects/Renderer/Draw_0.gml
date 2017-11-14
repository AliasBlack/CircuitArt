for (ind = 0; ind < ds_list_size(global.instructions); ind++) {
	temp = split(ds_list_find_value(global.instructions, ind), ";");
	arguments = split(temp[1], ",");
	switch (temp[0]) {
		case "draw_line":
			draw_line(real(arguments[0]), real(arguments[1]), real(arguments[2]), real(arguments[3]));
			break;
	}
}