switch global.currentBrush {
	case brush.polygon:
		ds_list_add(tempArguments, markerx, markery);
		break;
		
	case brush.line:
		if (ds_list_size(tempArguments) == 0) {
			ds_list_add(tempArguments, markerx, markery);
		} else {
			ds_list_add(global.instructions, 
				"draw_line;" +
				string(tempColor) + "," +
				string(tempAlpha) + "," +
				string(ds_list_find_value(tempArguments, 0)) + "," +
				string(ds_list_find_value(tempArguments, 1)) + "," +
				string(markerx) + "," +
				string(markery)
			);
			ds_list_clear(tempArguments);
		}
}