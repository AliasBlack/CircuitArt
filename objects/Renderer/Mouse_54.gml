if (global.currentBrush == brush.polygon) {
	if (mirror > 0 and mirrorJoined and ds_list_size(tempArguments) >= 4) {
		tempString = "";
		for (tempArg = 0; tempArg < ds_list_size(tempArguments); tempArg += 2) {
			tempString += "," + string(ds_list_find_value(tempArguments, tempArg));
			tempString += "," + string(ds_list_find_value(tempArguments, tempArg + 1));
			tempString += "," + string(mir(ds_list_find_value(tempArguments, tempArg)));
			tempString += "," + string(ds_list_find_value(tempArguments, tempArg + 1));
		}
		ds_list_add(global.instructions, "draw_triangleStrip;" + string(tempColor) + "," + string(tempAlpha) + tempString);
	} else if (ds_list_size(tempArguments) >= 6) {
		tempString = "";
		for (tempArg = 0; tempArg < ds_list_size(tempArguments); tempArg++) {
			tempString += "," + string(ds_list_find_value(tempArguments, tempArg));
		}
		ds_list_add(global.instructions, "draw_polygon;" + string(tempColor) + "," + string(tempAlpha) + tempString);
		if (mirror > 0) {
			tempString = "";
			for (tempArg = 0; tempArg < ds_list_size(tempArguments); tempArg++) {
				if (tempArg % 2 == 0) {
					tempString += "," + string(mir(ds_list_find_value(tempArguments, tempArg)));
				} else {
					tempString += "," + string(ds_list_find_value(tempArguments, tempArg));
				}
			}
			ds_list_add(global.instructions, "draw_polygon;" + string(tempColor) + "," + string(tempAlpha) + tempString);
		}
	}
	show_debug_message(tempString);
	ds_list_clear(tempArguments);
}