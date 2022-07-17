
var Ycent = window_get_height()/2; var Xcent = window_get_width()/2
var Mouse_X = device_mouse_x_to_gui(0); var Mouse_Y = device_mouse_y_to_gui(0); 
var Click = mouse_check_button_pressed(mb_left);

draw_sprite_ext(sp_inventory_bg,bg_subimage,Xcent,Ycent,scale,scale,0,c_white,1);
draw_sprite_ext(sp_xhair,bg_subimage,Mouse_X,Mouse_Y,scale,scale,0,c_white,1);

//+++++++++++++++++++++++++++++++++++++++ BUTTON CHECKS ++++++++++++++++++++++++++++++++++++++++++++

draw_text(Mouse_X+20,Mouse_Y,FPS);

if(Click) {
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,300,220,180,200,scale) && (Tab != "items")) {Tab = "items"; bg_subimage = 0};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,210,120,180,200,scale)) {Tab = "status"; bg_subimage = 6};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,114,24,180,200,scale)) {Tab = "skills"; bg_subimage = 7};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,18,-72,180,200,scale)) {Tab = "log"; bg_subimage = 8};
	
	if(Tab = "items") {
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,302,272,140,170,scale) && (SubTab != "weapons")) {SubTab = "weapons"; bg_subimage = 0};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,264,234,140,170,scale) && (SubTab != "armor")) {SubTab = "armor"; bg_subimage = 1};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,226,196,140,170,scale) && (SubTab != "aid")) {SubTab = "aid"; bg_subimage = 2};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,188,158,140,170,scale) && (SubTab != "ammo")) {SubTab = "ammo"; bg_subimage = 3};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,150,120,140,170,scale) && (SubTab != "currency")) {SubTab = "currency"; bg_subimage = 4};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,112,82,140,170,scale) && (SubTab != "crafting")) {SubTab = "crafting"; bg_subimage = 5};
	};

};

ButtonDrawCenter(305,215,180,200,scale);
ButtonDrawCenter(210,120,180,200,scale);
ButtonDrawCenter(114,24,180,200,scale);
ButtonDrawCenter(18,-72,180,200,scale);

ButtonDrawCenter(302,272,140,170,scale);
ButtonDrawCenter(264,234,140,170,scale);
ButtonDrawCenter(226,196,140,170,scale);
ButtonDrawCenter(188,158,140,170,scale);
ButtonDrawCenter(150,120,140,170,scale);
ButtonDrawCenter(112,82,140,170,scale);