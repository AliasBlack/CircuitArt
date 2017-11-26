// Current brush.
draw_set_color(c_white);
draw_set_alpha(1);
switch (global.currentBrush) {
	case brush.polygon:
		draw_text(20,20,"Polygon Tool");
		break;
		
	case brush.line:
		draw_text(20,20,"Line Tool");
		break;
}
draw_text(20,40,"1: Polygon, 2: Line");

// Color
draw_set_color(tempColor);
draw_text(20,80,"   Current Color");
draw_set_color(lastColor1);
draw_text(20,100, "W: Last Color 1");
draw_set_color(lastColor2);
draw_text(20,120, "E: Last Color 2");

// Mirror
draw_set_color(c_white);
draw_text(20, 160, (mirror > 0) ? "M: Mirror On" : "M: Mirror Off");
draw_set_alpha((mirror > 0) ? 1 : 0.5);
draw_text(20, 180, (mirrorJoined) ? "Joined mode" : "Separate Mode");