if (ds_list_size(global.instructions) > 0) {
	ds_list_delete(global.instructions, ds_list_size(global.instructions) - 1);
}