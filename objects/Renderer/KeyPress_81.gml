lastColor2 = lastColor1;
lastColor1 = tempColor;
tempColor =
	real (
		get_string (
			"Go to https://chrisanselmo.com/gmcolor/ to get a color code and paste it into the field below",
			""
		)
	);