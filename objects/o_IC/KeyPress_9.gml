if(active = 1) {
	active = 0;
	visible = 0;
	enable_mouseaim = 0;
	
	display_mouse_set(pos_at_close[0],pos_at_close[1]);
	x = pos_at_close[2]; y = pos_at_close[3]; 
	
	enable_mouseaim = 1;
	global.Selected = [-1,-1];
	exit;
};

if(active = 0) {
	enable_mouseaim = 0;
	active = 1;
	visible = 1;
	pos_at_close = [display_mouse_get_x(),display_mouse_get_y(),x,y];
	counter_weapons = 0;
	counter_armor = 0;
	counter_aid = 0;
	counter_ammo = 0;
	counter_crafting = 0;
	
	incrementor_weapons = 0;
	incrementor_armor = 0;
	incrementor_aid = 0;
	incrementor_ammo = 0;
	incrementor_crafting = 0;	
	exit;
};


