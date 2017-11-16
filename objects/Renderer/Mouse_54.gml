if (global.currentBrush == brush.polygon) and (ds_list_size(tempArguments) >= 6) {
	tempString = "";
	for (tempArg = 0; tempArg < ds_list_size(tempArguments); tempArg++) {
		tempString += "," + string(ds_list_find_value(tempArguments, tempArg));
	}
	ds_list_add(global.instructions, "draw_polygon;" + string(tempColor) + "," + string(tempAlpha) + tempString);
	show_debug_message("draw_polygon;" + string(tempColor) + "," + string(tempAlpha) + tempString);
	ds_list_clear(tempArguments);
}