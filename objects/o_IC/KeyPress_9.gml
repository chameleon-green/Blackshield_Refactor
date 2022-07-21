

if(visible) {
	
	gui_close_toggle = 0;
	
	var XX = (view_wport[0] / 2);
	var YY = (view_hport[0] / 2);
	camera_set_view_pos(view_camera[0],o_player.x-10,o_player.y-10);

	var _cx = camera_get_view_x(view_camera[0]);
	var _cy = camera_get_view_y(view_camera[0]);
	var _x = (o_player.x - _cx);
    var _y = (o_player.y - _cy);
    window_mouse_set(_x,_y);
	
	gui_close_toggle = 1;
	global.Selected = undefined;
};

if(!visible) {
	counter_weapons = 0;
	counter_armor = 0;
	counter_aid = 0;
	counter_ammo = 0;
	counter_crafting = 0;
};

visible = !visible;
