
Mouse_X = device_mouse_x_to_gui(0); 
Mouse_Y = device_mouse_y_to_gui(0); 
var Click = mouse_check_button_pressed(mb_left);
var Ycent = window_get_height()/2; var Xcent = window_get_width()/2;

draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_sprite_ext(sp_inventory_bg,bg_subimage,Xcent,Ycent,scale,scale,0,c_white,1);

//+++++++++++++++++++++++++++++++++++++++ BUTTON CHECKS ++++++++++++++++++++++++++++++++++++++++++++

#region Button Checks

if(Click) {
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,300,220,180,200,scale) && (Tab != "items")) {
		Tab = "items"; bg_subimage = 0; 
		global.Selected = [-1,-1];
		refresh = 1; 
	};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,210,120,180,200,scale)) {Tab = "status"; bg_subimage = 6; global.Selected = [-1,-1]};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,114,24,180,200,scale)) {Tab = "skills"; bg_subimage = 7; global.Selected = [-1,-1]};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,18,-72,180,200,scale)) {Tab = "log"; bg_subimage = 8; global.Selected = [-1,-1]};
	
	if(Tab = "items") {
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,302,272,140,170,scale) && (SubTab != "weapons")) {
			SubTab = "weapons"; 
			bg_subimage = 0; counter_weapons = 0; incrementor_weapons = 0; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,264,234,140,170,scale) && (SubTab != "armor")) {
			SubTab = "armor"; 
			bg_subimage = 1; counter_armor = 0; incrementor_armor = 0; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,226,196,140,170,scale) && (SubTab != "aid")) {
			SubTab = "aid"; 
			bg_subimage = 2 counter_aid = 0; incrementor_aid = 0; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,188,158,140,170,scale) && (SubTab != "ammo")) {
			SubTab = "ammo"; 
			bg_subimage = 3 counter_ammo = 0; incrementor_ammo = 0; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,150,120,140,170,scale) && (SubTab != "currency")) {
			SubTab = "currency"; bg_subimage = 4; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,112,82,140,170,scale) && (SubTab != "crafting")) {
			SubTab = "crafting"; 
			bg_subimage = 5 counter_crafting = 0; incrementor_crafting = 0; 
			global.Selected = [-1,-1];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-40,-112,-49,-19,scale) and is_struct(global.Selected[1]) ){
			EquipItem(global.Selected[1],global.Selected[0],MyPlayer);
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-122,-216,-19,-49,scale)){
			Description = 1;
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-223,-280,-19,-49,scale)){
			Drop = 1;
		};

	};
};
/*
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
*/
if(refresh) {
	instance_destroy(o_inventory_item);
	refresh = 0;
	counter_weapons = 0; incrementor_weapons = 0; 
	counter_armor = 0; incrementor_armor = 0; 
	counter_aid = 0; incrementor_aid = 0; 
	counter_ammo = 0; incrementor_ammo = 0; 
	counter_crafting = 0; incrementor_crafting = 0; 
	ds_grid_alphabetize(grd_inv_wepn);
	ds_grid_alphabetize(grd_inv_ammo);
	ds_grid_alphabetize(grd_inv_aidd);
	ds_grid_alphabetize(grd_inv_armr);
};

#endregion

//++++++++++++++++++++++++++++++++++ INVENTORY ITEM GENERATION +++++++++++++++++++++++++++++++++++++

if(Tab = "items") {

	TriButtonColors = [c_dkgray,c_dkgray,c_dkgray];
	TriButtonFrames = [0,2,4];
	TriButtonText = ["Equip","Description","Drop"];
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-40,-112,-49,-19,scale)){
		TriButtonColors[0] = c_yellow;
		TriButtonFrames[0] = 1;
	};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-122,-216,-49,-19,scale)){
		TriButtonColors[1] = c_yellow;
		TriButtonFrames[1] = 3;
	};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-223,-280,-49,-19,scale)){
		TriButtonColors[2] = c_yellow;
		TriButtonFrames[2] = 5;
	};
	
	//----------------------------------------------- Weapons Subtab ------------------------------------------
	#region weapons subtab
	if(SubTab = "weapons") {
		
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		
		//item stats screen and display
		draw_sprite_ext(sp_inventory_screen,0,Xcent+160*scale,Ycent-60*scale,scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,0,Xcent+160*scale,Ycent+102*scale,scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+76*scale,Ycent+34*scale,scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+76*scale,Ycent+25*scale,TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+168*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+169*scale,Ycent+26.5*scale,TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+251*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+251*scale,Ycent+25*scale,TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
		while(incrementor_weapons < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_wepn,0,incrementor_weapons)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_wepn,8,incrementor_weapons);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					GridYValue : other.incrementor_weapons,
					MyTab : Tab,
					MySubTab : SubTab,
					creator : id, 
					yoffset : counter_weapons,
					item : Slot,
					unique_id : ID,
					scrollbar : MyScrollbar,
					grid : grd_inv_wepn,
					MyPlayer : MyPlayer
				})
				counter_weapons += 1;
				MyScrollbar.item_count = counter_weapons;
			};
			incrementor_weapons += 1;	
		};//while loop
	};//weapons tab check
	#endregion
	//-------------------------------------------------- Armor Subtab ----------------------------------------------
	#region armor subtab
	if(SubTab = "armor") {
		
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		
		//item stats screen and display
		draw_sprite_ext(sp_inventory_screen,0,Xcent+160*scale,Ycent-60*scale,scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,0,Xcent+160*scale,Ycent+102*scale,scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+76*scale,Ycent+34*scale,scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+76*scale,Ycent+25*scale,TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+168*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+169*scale,Ycent+26.5*scale,TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+251*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+251*scale,Ycent+25*scale,TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
		while(incrementor_armor < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_armr,0,incrementor_armor)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_armr,8,incrementor_armor);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					GridYValue : other.incrementor_armor,
					MyTab : Tab,
					MySubTab : SubTab,
					creator : id, 
					yoffset : counter_armor,
					item : Slot,
					unique_id : ID,
					scrollbar : MyScrollbar,
					grid : grd_inv_armr,
					MyPlayer : MyPlayer
				})
				counter_armor += 1;
				MyScrollbar.item_count = counter_armor;
			};
			incrementor_armor += 1;	
		};//while loop
	};//armor tab check
	#endregion
	//-------------------------------------------------- Aid Subtab ------------------------------------------------
	#region aid subtab
	if(SubTab = "aid") {
		
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		
		//item stats screen and display
		draw_sprite_ext(sp_inventory_screen,0,Xcent+160*scale,Ycent-60*scale,scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,0,Xcent+160*scale,Ycent+102*scale,scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+76*scale,Ycent+34*scale,scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+76*scale,Ycent+25*scale,TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+168*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+169*scale,Ycent+26.5*scale,TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+251*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+251*scale,Ycent+25*scale,TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
		while(incrementor_aid < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_aidd,0,incrementor_aid)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_aidd,8,incrementor_aid);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					GridYValue : other.incrementor_aid,
					MyTab : Tab,
					MySubTab : SubTab,
					creator : id, 
					yoffset : counter_aid,
					item : Slot,
					unique_id : ID,
					scrollbar : MyScrollbar,
					grid : grd_inv_aidd,
					MyPlayer : MyPlayer
				})
				counter_aid += 1;
				MyScrollbar.item_count = counter_aid;
			};
			incrementor_aid += 1;	
		};//while loop
	};//aid tab check
	#endregion
	//-------------------------------------------------- Ammo Subtab------------------------------------------------
	#region ammo subtab
	if(SubTab = "ammo") {
		
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		
		//stats and item display
		draw_sprite_ext(sp_inventory_screen,0,Xcent+160*scale,Ycent-60*scale,scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,4,Xcent+160*scale,Ycent+102*scale,scale,scale,0,c_white,1);
				
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+76*scale,Ycent+34*scale,scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+76*scale,Ycent+25*scale,TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+168*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+169*scale,Ycent+26.5*scale,TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+251*scale,Ycent+34*scale,scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+251*scale,Ycent+25*scale,TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
			
		while(incrementor_ammo < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_ammo,0,incrementor_ammo)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_ammo,8,incrementor_ammo);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					GridYValue : other.incrementor_ammo,
					MyTab : Tab,
					MySubTab : SubTab,
					creator : id, 
					yoffset : counter_ammo,
					item : Slot,
					unique_id : ID,
					scrollbar : MyScrollbar,
					grid : grd_inv_ammo,
					MyPlayer : MyPlayer
				})
				counter_ammo += 1;
				MyScrollbar.item_count = counter_ammo;
			};
			incrementor_ammo += 1;	
		};//while loop
	};//ammo tab check
	#endregion
};//items tab check