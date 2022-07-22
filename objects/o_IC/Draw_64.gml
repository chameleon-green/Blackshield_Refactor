

Mouse_X = device_mouse_x_to_gui(0); 
Mouse_Y = device_mouse_y_to_gui(0); 
var Click = mouse_check_button_pressed(mb_left);
var Ycent = window_get_height()/2; var Xcent = window_get_width()/2;

draw_sprite_ext(sp_inventory_bg,bg_subimage,Xcent,Ycent,scale,scale,0,c_white,1);

//+++++++++++++++++++++++++++++++++++++++ BUTTON CHECKS ++++++++++++++++++++++++++++++++++++++++++++

#region Button Checks

if(Click) {
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,300,220,180,200,scale) && (Tab != "items")) {Tab = "items"; bg_subimage = 0; global.Selected = undefined};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,210,120,180,200,scale)) {Tab = "status"; bg_subimage = 6; global.Selected = undefined};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,114,24,180,200,scale)) {Tab = "skills"; bg_subimage = 7; global.Selected = undefined};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,18,-72,180,200,scale)) {Tab = "log"; bg_subimage = 8; global.Selected = undefined};
	
	if(Tab = "items") {
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,302,272,140,170,scale) && (SubTab != "weapons")) {SubTab = "weapons"; bg_subimage = 0; counter_weapons = 0; incrementor_weapons = 0; global.Selected = undefined};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,264,234,140,170,scale) && (SubTab != "armor")) {SubTab = "armor"; bg_subimage = 1 counter_armor = 0; incrementor_armor = 0; global.Selected = undefined};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,226,196,140,170,scale) && (SubTab != "aid")) {SubTab = "aid"; bg_subimage = 2 counter_aid = 0; incrementor_aid = 0; global.Selected = undefined};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,188,158,140,170,scale) && (SubTab != "ammo")) {SubTab = "ammo"; bg_subimage = 3 counter_ammo = 0; incrementor_ammo = 0; global.Selected = undefined};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,150,120,140,170,scale) && (SubTab != "currency")) {SubTab = "currency"; bg_subimage = 4; global.Selected = undefined};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,112,82,140,170,scale) && (SubTab != "crafting")) {SubTab = "crafting"; bg_subimage = 5 counter_crafting = 0; incrementor_crafting = 0; global.Selected = undefined};
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

#endregion

//++++++++++++++++++++++++++++++++++ INVENTORY ITEM GENERATION +++++++++++++++++++++++++++++++++++++

/*
draw_text(Mouse_X,Mouse_Y+10,ds_grid_get(grd_inv_wepn,8,0));
draw_text(Mouse_X,Mouse_Y+20,ds_grid_get(grd_inv_wepn,0,1));
draw_text(Mouse_X,Mouse_Y+30,ds_grid_get(grd_inv_wepn,0,2));
*/

if(Tab = "items") {
	
	if(SubTab = "weapons") {
		while(incrementor_weapons < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_wepn,0,incrementor_weapons)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_wepn,8,incrementor_weapons);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					creator : id, 
					yoffset : counter_weapons,
					item : Slot,
					unique_id : ID
				})
				counter_weapons += 1;
			};
			incrementor_weapons += 1;	
		};//while loop
	};//weapons tab check

};//items tab check