// Get min/max x and y coords.
minX = room_width;
minY = room_height;
maxX = 0;
maxY = 0;
for (adOri = 0; adOri < ds_list_size(global.instructions); adOri++) {
	coords = split(ds_list_find_value(global.instructions, adOri), ";");
	coords = split(coords[1], ",");
	for (coordCount = 2; coordCount < array_length_1d(coords); coordCount++) {
		if (coordCount % 2 == 0) {
			minX = real(min(minX, coords[coordCount]));
			maxX = real(max(maxX, coords[coordCount]));
		} else {
			minY = real(min(minY, coords[coordCount]));
			maxY = real(max(maxY, coords[coordCount]));
		}
	}
}

// Adjust all instructions to origin.
tempInstruct = ds_list_create();
for (adOri = 0; adOri < ds_list_size(global.instructions); adOri++) {
	coords = split(ds_list_find_value(global.instructions, adOri), ";");
	instruct = coords[0];
	coords = split(coords[1], ",");
	instruct += ";" + coords[0] + "," + coords[1];
	for (coordCount = 2; coordCount < array_length_1d(coords); coordCount++) {
		if (coordCount % 2 == 0) {
			instruct += "," + string(real(coords[coordCount]) - minX);
		} else {
			instruct += "," + string(real(coords[coordCount]) - minY);
		}
	}
	//ds_list_replace(global.instructions, adOri, instruct);
	ds_list_add(tempInstruct, instruct);
}
file = file_text_open_write(get_save_filename("",""));
file_text_write_string(file, ds_list_write(tempInstruct));
file_text_close(file);