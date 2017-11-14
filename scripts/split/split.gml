array = 0;
lastComma = 1;
for (i = 1; i <= string_length(argument0); i++) {
	if (i != string_length(argument0)) {
		if (string_copy(argument0, i, 1) != argument1) {
			continue;
		} else {
			array[array_length_1d(array)] = string_copy(argument0, lastComma, i - lastComma);
			lastComma = i + 1;
		}
	} else {
		array[array_length_1d(array)] = string_copy(argument0, lastComma, i - lastComma + 1);
	}
}
return array;