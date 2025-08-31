
Mouse_X = device_mouse_x_to_gui(0); 
Mouse_Y = device_mouse_y_to_gui(0); 
var Click = mouse_check_button_pressed(mb_left);
var Ycent = display_get_gui_height()/2; var Xcent = display_get_gui_width()/2;
var YoffS = Yoffset*scale;
var XoffS = Xoffset*scale;

draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_sprite_ext(sp_inventory_bg,bg_subimage,Xcent+XoffS,Ycent+YoffS,scale,scale,0,c_white,1);

//++++++++++++++++++++++++++++++++++ INVENTORY ITEM GENERATION +++++++++++++++++++++++++++++++++++++

if(Tab = "items") {

	TriButtonColors = [c_dkgray,c_dkgray,c_dkgray];
	TriButtonFrames = [0,2,4];
	TriButtonText = ["Equip","Description","Drop"];
	var _Selected = global.Selected;
	var IsEquipped = ((MyPlayer.wpn_primary_id = _Selected[0]) or 
				   (MyPlayer.wpn_secondary_id = _Selected[0]) or
				   (MyPlayer.wpn_melee_id = _Selected[0]) or
				   (MyPlayer.armor_head[1] = _Selected[0]) or
				   (MyPlayer.armor_torso[1] = _Selected[0]) or
				   (MyPlayer.armor_armL[1] = _Selected[0]) or
				   (MyPlayer.armor_armR[1] = _Selected[0]) or
				   (MyPlayer.armor_legL[1] = _Selected[0]) or
				   (MyPlayer.armor_legR[1] = _Selected[0])
	);	
	
	if(IsEquipped) {TriButtonText[0] = "Unequip"};
	
	var IsEquippedAmmoPrimary = (MyPlayer.ammo_primary = _Selected[1]);
	var IsEquippedAmmoSecondary = (MyPlayer.ammo_secondary = _Selected[1]);
	var IsEquippedAmmoBoth = (IsEquippedAmmoPrimary & IsEquippedAmmoSecondary);
	
	/*
	var IsEquippedAmmo = (
		(MyPlayer.ammo_primary = _Selected[1]) or 
		(MyPlayer.ammo_secondary = _Selected[1]) or 
		(MyPlayer.ammo_active = _Selected[1])
	);	
	
	if(IsEquippedAmmo) {TriButtonText[0] = "Equipped"; TriButtonColors[0] = c_yellow};
	*/
	
	if(IsEquippedAmmoPrimary & (MyPlayer.wpn_active = MyPlayer.wpn_primary)) {TriButtonText[0] = "Equipped"; TriButtonColors[0] = c_yellow}
	else if(IsEquippedAmmoSecondary & (MyPlayer.wpn_active = MyPlayer.wpn_secondary)) {TriButtonText[0] = "Equipped"; TriButtonColors[0] = c_yellow}
	else if(IsEquippedAmmoBoth) {TriButtonText[0] = "Equipped"; TriButtonColors[0] = c_yellow};
	
	if(SubTab = "aid") {TriButtonText[0] = "Use"};
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-40,-112,-49,-19,scale,Xoffset,Yoffset)){
		TriButtonColors[0] = c_yellow;
		TriButtonFrames[0] = 1;
	};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-122,-216,-49,-19,scale,Xoffset,Yoffset)){
		TriButtonColors[1] = c_yellow;
		TriButtonFrames[1] = 3;
	};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,-223,-280,-49,-19,scale,Xoffset,Yoffset)){
		TriButtonColors[2] = c_yellow;
		TriButtonFrames[2] = 5;
	};
	
	//----------------------------------------------- Weapons Subtab ------------------------------------------
	
	#region weapons subtab
	if(SubTab = "weapons") {
		
		if(MyScrollbar = 0) {MyScrollbar = instance_create_depth(x,y,depth-1,o_scrollbar,{creator : id})};
		
		//item stats screen and display
		draw_sprite_ext(sp_inventory_screen,0,Xcent+XoffS+(160*scale),Ycent+((Yoffset-60)*scale),scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,0,Xcent+XoffS+(160*scale),Ycent+((Yoffset+102)*scale),scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+XoffS+(76*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(76*scale),Ycent+YoffS+(25*scale),TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+XoffS+(168*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(169*scale),Ycent+YoffS+(26.5*scale),TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+XoffS+(251*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(251*scale),Ycent+YoffS+(25*scale),TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
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
		draw_sprite_ext(sp_inventory_screen,0,Xcent+XoffS+(160*scale),Ycent+YoffS-(60*scale),scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,2,Xcent+XoffS+(160*scale),Ycent+YoffS+(102*scale),scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+XoffS+(76*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(76*scale),Ycent+YoffS+(25*scale),TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+XoffS+(168*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(169*scale),Ycent+YoffS+(26.5*scale),TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+XoffS+(251*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(251*scale),Ycent+YoffS+(25*scale),TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
		while(incrementor_armor < (InventorySize-1)) {
			var Slot = ds_grid_get(grd_inv_armr,0,incrementor_armor)
			if(Slot != 0) {						
				var ID = ds_grid_get(grd_inv_armr,8,incrementor_armor);
				instance_create_depth(x,y,depth-1,o_inventory_item,{
					GridYValue : incrementor_armor,
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
		draw_sprite_ext(sp_inventory_screen,0,Xcent+XoffS+(160*scale),Ycent+YoffS-(60*scale),scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,0,Xcent+XoffS+(160*scale),Ycent+YoffS+(102*scale),scale,scale,0,c_white,1);
		
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+XoffS+(76*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(76*scale),Ycent+YoffS+(25*scale),TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+XoffS+(168*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(169*scale),Ycent+YoffS+(26.5*scale),TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+XoffS+(251*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(251*scale),Ycent+YoffS+(25*scale),TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
		
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
		draw_sprite_ext(sp_inventory_screen,0,Xcent+XoffS+(160*scale),Ycent+YoffS-(60*scale),scale,scale,0,c_white,1);
		draw_sprite_ext(sp_inventory_wep_stats,4,Xcent+XoffS+(160*scale),Ycent+YoffS+(102*scale),scale,scale,0,c_white,1);
				
		//equip button draw
		draw_sprite_ext(sp_button,TriButtonFrames[0],Xcent+XoffS+(76*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(76*scale),Ycent+YoffS+(25*scale),TriButtonText[0],0,500,scale,scale,0,TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],TriButtonColors[0],1);	
		//desc button draw
		draw_sprite_ext(sp_button,TriButtonFrames[1],Xcent+XoffS+(168*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(169*scale),Ycent+YoffS+(26.5*scale),TriButtonText[1],0,500,scale*0.95,scale*0.95,0,TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],TriButtonColors[1],1);	
		//drop button draw
		draw_sprite_ext(sp_button,TriButtonFrames[2],Xcent+XoffS+(251*scale),Ycent+YoffS+(34*scale),scale,scale,0,c_white,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(251*scale),Ycent+YoffS+(25*scale),TriButtonText[2],0,500,scale,scale,0,TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],TriButtonColors[2],1);
			
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

//+++++++++++++++++++++++++++++++++++++++++++ STATUS TAB +++++++++++++++++++++++++++++++++++++++++++++++

if(Tab = "status") {
	
	//--USE THIS TO SHIFT ENTIRE STATUS DISPLAY--
	var YoffS = (Yoffset+1)*scale;
	var XoffS = (Xoffset+1)*scale;
	//--USE THIS TO SHIFT ENTIRE STATUS DISPLAY--
	
	var SPHeadArmor = MyPlayer.armor_head[0].status_subimage;
	var SPTorsoArmor = MyPlayer.armor_torso[0].status_subimage;
	var SPArmLArmor = MyPlayer.armor_armL[0].status_subimage;
	var SPArmRArmor = MyPlayer.armor_armR[0].status_subimage;
	var SPLegLArmor = MyPlayer.armor_legL[0].status_subimage;
	var SPLegRArmor = MyPlayer.armor_legR[0].status_subimage;
	
	var ClrTorsoArmor = ChooseColor(MyPlayer.armor_torso[3],1);
	var ClrHeadArmor = ChooseColor(MyPlayer.armor_head[3],1);
	var ClrArmLArmor = ChooseColor(MyPlayer.armor_armL[3],1);
	var ClrArmRArmor = ChooseColor(MyPlayer.armor_armR[3],1);
	var ClrLegLArmor = ChooseColor(MyPlayer.armor_legL[3],1);
	var ClrLegRArmor = ChooseColor(MyPlayer.armor_legR[3],1);
	
	var ClrTorso = ChooseColor(MyPlayer.hp_body_torso/MyPlayer.hp_body_torso_max,1,MyPlayer.armor_torso[5]);
	var ClrHead = ChooseColor(MyPlayer.hp_body_head/MyPlayer.hp_body_head_max,1,MyPlayer.armor_head[5]);
	var ClrArmL = ChooseColor(MyPlayer.hp_body_armL/MyPlayer.hp_body_armL_max,1,MyPlayer.armor_armL[5]);
	var ClrArmR = ChooseColor(MyPlayer.hp_body_armR/MyPlayer.hp_body_armR_max,1,MyPlayer.armor_armR[5]);
	var ClrLegL = ChooseColor(MyPlayer.hp_body_legL/MyPlayer.hp_body_legL_max,1,MyPlayer.armor_legL[5]);
	var ClrLegR = ChooseColor(MyPlayer.hp_body_legR/MyPlayer.hp_body_legR_max,1,MyPlayer.armor_legR[5]);
	
	var AlpTorsoArmor = 1;
	var AlpHeadArmor = 1;
	var AlpArmLArmor = 1;
	var AlpArmRArmor = 1;
	var AlpLegLArmor = 1;
	var AlpLegRArmor = 1;
	
	draw_sprite_ext(sp_inventory_screen,12,Xcent+XoffS,Ycent+YoffS+(9*scale),scale,scale*1.01,0,c_white,1); //draw big screen
	
	gpu_set_fog(1,ClrTorsoArmor,1,1); //draw colored outline of armor	
	draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1); 
	gpu_set_fog(1,ClrHeadArmor,1,1); //draw colored outline of armor	
	draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1); 
	gpu_set_fog(1,ClrArmLArmor,1,1); //draw colored outline of armor	
	draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1); 
	draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1); 
	gpu_set_fog(1,ClrArmRArmor,1,1); //draw colored outline of armor	
	draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1);
	gpu_set_fog(1,ClrLegLArmor,1,1); //draw colored outline of armor	
	draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1);
	gpu_set_fog(1,ClrLegRArmor,1,1); //draw colored outline of armor		
	draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS+(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS-(2*scale),Ycent+YoffS+(29*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS,Ycent+YoffS+(27*scale),scale*1.01,scale*1.01,0,c_white,1);
	draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS,Ycent+YoffS+(31*scale),scale*1.01,scale*1.01,0,c_white,1);	
	gpu_set_fog(1,CL_Screen,1,1);	//draw dark background of limb template
	draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1); 
	draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1); 
	draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1); 
	draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1);
	draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1);
	draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,c_white,1);
	gpu_set_fog(0,CL_Screen,0,0);	
	//draw actual skeleton
	draw_sprite_ext(sp_statusbody_bones,6,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrTorso,1); 
	draw_sprite_ext(sp_statusbody_bones,8,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrArmL,1); 
	draw_sprite_ext(sp_statusbody_bones,9,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrArmR,1); 
	draw_sprite_ext(sp_statusbody_bones,10,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrLegL,1); 
	draw_sprite_ext(sp_statusbody_bones,11,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrLegR,1); 
	
	if(ClrTorso != CL_Yellow) {AlpTorsoArmor = 0.4};
	if(ClrHead != CL_Yellow) {AlpHeadArmor = 0.4};
	if(ClrArmL != CL_Yellow) {AlpArmLArmor = 0.4};
	if(ClrArmR != CL_Yellow) {AlpArmRArmor = 0.4};
	if(ClrLegL != CL_Yellow) {AlpLegLArmor = 0.4};
	if(ClrLegR != CL_Yellow) {AlpLegRArmor = 0.4};
	
	if(MyPlayer.armor_legL[3] > 0) {draw_sprite_ext(SPLegLArmor[0],SPLegLArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrLegLArmor,AlpLegLArmor)};
	if(MyPlayer.armor_legR[3] > 0) {draw_sprite_ext(SPLegRArmor[0],SPLegRArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrLegRArmor,AlpLegRArmor)};
	if(MyPlayer.armor_torso[3] > 0) {draw_sprite_ext(SPTorsoArmor[0],SPTorsoArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrTorsoArmor,AlpTorsoArmor)}; 
	draw_sprite_ext(sp_statusbody_bones,7,Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrHead,1); //draw skull over torso, below helmet
	if(MyPlayer.armor_head[3] > 0) {draw_sprite_ext(SPHeadArmor[0],SPHeadArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrHeadArmor,AlpHeadArmor)}; 
	if(MyPlayer.armor_armL[3] > 0) {draw_sprite_ext(SPArmLArmor[0],SPArmLArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrArmLArmor,AlpArmLArmor)}; 
	if(MyPlayer.armor_armR[3] > 0) {draw_sprite_ext(SPArmRArmor[0],SPArmRArmor[1],Xcent+XoffS,Ycent+YoffS+(29*scale),scale,scale,0,ClrArmRArmor,AlpArmRArmor)};
	
	
	//----------------------------------------- LEFT SIDE ARMOR DAMAGE -----------------------------------------------
	
	
	if(MyPlayer.armor_torso[3] <= 0.85){
		//difference of -28 for bubble to title text
		//difference of -9 for bubble to detail text
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_torso[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%";
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,8,Xcent+XoffS+(-45*scale),Ycent+YoffS+(-128*scale),scale,scale,0,ClrTorsoArmor,1);  //BUBBLE ARROW
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(-60*scale),Ycent+YoffS+(-126*scale),scale,scale,0,ClrTorsoArmor,1); //BUBBLE
		 
		draw_text_transformed(Xcent+XoffS+(-60*scale),Ycent+YoffS+(-154*scale),Text,scale*0.57,scale*0.6,0); //DAMAGE TEXT
		draw_text_transformed(Xcent+XoffS+(-55*scale),Ycent+YoffS+(-135*scale),Text2,scale*0.57,scale*0.6,0); //PERCENT DURABILITY TEXT
		draw_set_colour(c_white);
	};
	
	
	if(MyPlayer.armor_armL[3] <= 0.85){
		//difference of -28 for bubble to title text
		//difference of -9 for bubble to detail text
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_armL[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%";
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,5,Xcent+XoffS+(-104*scale),Ycent+YoffS+(-32*scale),-scale,scale,0,ClrArmLArmor,1); //BUBBLE ARROW
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(-135*scale),Ycent+YoffS+(-13*scale),scale,scale,0,ClrArmLArmor,1); //BUBBLE 

		draw_text_transformed(Xcent+XoffS+(-135*scale),Ycent+YoffS+(-41*scale),Text,scale*0.57,scale*0.6,0); //DAMAGE TEXT
		draw_text_transformed(Xcent+XoffS+(-130*scale),Ycent+YoffS+(-22*scale),Text2,scale*0.57,scale*0.6,0); //PERCENT DURABILITY TEXT
		draw_set_colour(c_white);
	};
	
	if(MyPlayer.armor_legL[3] <= 0.85){
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_legL[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%"
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,6,Xcent+XoffS+(-104*scale),Ycent+YoffS+(87*scale),-scale,scale,0,ClrLegLArmor,1); //BUBBLE ARROW
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(-135*scale),Ycent+YoffS+(102*scale),scale,scale,0,ClrLegLArmor,1); //BUBBLE 
	
		draw_text_transformed(Xcent+XoffS+(-135*scale),Ycent+YoffS+(74*scale),Text,scale*0.57,scale*0.6,0); //DAMAGE TEXT
		draw_text_transformed(Xcent+XoffS+(-130*scale),Ycent+YoffS+(93*scale),Text2,scale*0.57,scale*0.6,0); //PERCENT DURABILITY TEXT
		draw_set_colour(c_white);
	};
	
	//----------------------------------------- RIGHT SIDE ARMOR DAMAGE -----------------------------------------------
	
	if(MyPlayer.armor_head[3] <= 0.85){
		//difference of -28 for bubble to title text
		//difference of -9 for bubble to detail text
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_head[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%";
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,9,Xcent+XoffS+(60*scale),Ycent+YoffS+(-128*scale),scale,scale,0,ClrHeadArmor,1);  //BUBBLE ARROW
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(60*scale),Ycent+YoffS+(-126*scale),scale,scale,0,ClrHeadArmor,1); //BUBBLE
		 
		draw_text_transformed(Xcent+XoffS+(60*scale),Ycent+YoffS+(-154*scale),Text,scale*0.57,scale*0.6,0); //DAMAGE TEXT
		draw_text_transformed(Xcent+XoffS+(65*scale),Ycent+YoffS+(-135*scale),Text2,scale*0.57,scale*0.6,0); //PERCENT DURABILITY TEXT
		draw_set_colour(c_white);
	};
	
	
	if(MyPlayer.armor_armR[3] <= 0.85){
		//difference of -29 for bubble to title text
		//difference of -9 for bubble to detail text
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_armR[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%";
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,5,Xcent+XoffS+(104*scale),Ycent+YoffS+(-32*scale),scale,scale,0,ClrArmRArmor,1); 
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(135*scale),Ycent+YoffS+(-13*scale),scale,scale,0,ClrArmRArmor,1);

		draw_text_transformed(Xcent+XoffS+(135*scale),Ycent+YoffS+(-41*scale),Text,scale*0.57,scale*0.6,0);
		draw_text_transformed(Xcent+XoffS+(140*scale),Ycent+YoffS+(-22*scale),Text2,scale*0.57,scale*0.6,0);
		draw_set_colour(c_white);
	};
	
	if(MyPlayer.armor_legR[3] <= 0.85){
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_legR[3];
		var Text = "MINOR DAMAGE";
		var Text2 = "INTEGRITY: " + string(round(Ratio*100)) + "%"
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR DAMAGE"};
		if(Ratio > 0 and Ratio <= 0.33) {Text = "CRITICAL DAMAGE"};
		if(Ratio = 0) {Text = "DESTROYED"}
		
		draw_sprite_ext(sp_statusbubble,6,Xcent+XoffS+(104*scale),Ycent+YoffS+(87*scale),scale,scale,0,ClrLegRArmor,1);
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(135*scale),Ycent+YoffS+(102*scale),scale,scale,0,ClrLegRArmor,1); 
 
		draw_text_transformed(Xcent+XoffS+(135*scale),Ycent+YoffS+(74*scale),Text,scale*0.57,scale*0.6,0);
		draw_text_transformed(Xcent+XoffS+(140*scale),Ycent+YoffS+(93*scale),Text2,scale*0.57,scale*0.6,0);
		draw_set_colour(c_white);
	};
	
	
	//----------------------------------------- LEFT SIDE WOUND STATES -----------------------------------------------
	
	if(MyPlayer.armor_armL[6] <= 0.75){
		//difference of -28 for bubble to title text
		//difference of -9 for bubble to detail text
		draw_set_halign(fa_center);
		draw_set_colour(CL_Screen);
		var Ratio = MyPlayer.armor_armL[6];
		var Text = "MINOR INJURY";
		var Text2 = "LIMB STATE: " + string(round(Ratio*100)) + "%";
		var Text3 = "HELLO \n WORLD";
		if(Ratio > 0.33 and Ratio < 0.75) {Text = "MAJOR INJURY"};
		if(Ratio >= 0 and Ratio <= 0.33) {Text = "CRITICAL INJURY"};
		if(MyPlayer.armor_armL[3] = true) {Text = "AMPUTATED"};
		
		//draw_sprite_ext(sp_statusbubble,5,Xcent+XoffS+(-95*scale),Ycent+YoffS+(-32*scale),-scale,scale,0,ClrArmLArmor,1); //BUBBLE ARROW
		draw_sprite_ext(sp_statusbubble,4,Xcent+XoffS+(-135*scale),Ycent+YoffS+(+30*scale),scale,scale,0,ClrArmL,1); //BUBBLE EXTENSION
		draw_sprite_ext(sp_statusbubble,0,Xcent+XoffS+(-135*scale),Ycent+YoffS+(+30*scale),scale,scale,0,ClrArmL,1); //BUBBLE 
		
		draw_text_transformed(Xcent+XoffS+(-135*scale),Ycent+YoffS+(+2*scale),Text,scale*0.57,scale*0.6,0); //DAMAGE TEXT
		draw_text_transformed(Xcent+XoffS+(-130*scale),Ycent+YoffS+(+21*scale),Text2,scale*0.57,scale*0.6,0); //PERCENT DURABILITY TEXT
		draw_set_valign(fa_top);
		draw_text_transformed(Xcent+XoffS+(-130*scale),Ycent+YoffS+(+33*scale),Text3,scale*0.57,scale*0.6,0); //STAT EFFECT TEXT
		draw_set_colour(c_white);
	};
	
}; //status tab check

var YoffS = Yoffset*scale;
var XoffS = Xoffset*scale;

//+++++++++++++++++++++++++++++++++++++++ BUTTON CHECKS ++++++++++++++++++++++++++++++++++++++++++++

#region Button Checks

if(Click) {
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,300,220,180,200,scale,Xoffset,Yoffset) && (Tab != "items")) {
		Tab = "items"; bg_subimage = 0; 
		global.Selected = ["none","none"];
		if(SubTab = "weapons") {bg_subimage = 0}
		else if(SubTab = "armor") {bg_subimage = 1}
		else if(SubTab = "aid") {bg_subimage = 2}
		else if(SubTab = "ammo") {bg_subimage = 3}
		else if(SubTab = "currency") {bg_subimage = 4}
		else if(SubTab = "crafting") {bg_subimage = 5}
		refresh = 1; 
	};
	
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,210,120,180,200,scale,Xoffset,Yoffset)) {Tab = "status"; bg_subimage = 6; global.Selected = ["none","none"]};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,114,24,180,200,scale,Xoffset,Yoffset)) {Tab = "skills"; bg_subimage = 7; global.Selected = ["none","none"]};
	if(ButtonRegionCenter(Mouse_X,Mouse_Y,18,-72,180,200,scale,Xoffset,Yoffset)) {Tab = "log"; bg_subimage = 8; global.Selected = ["none","none"]};
	
	if(Tab = "items") {
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,302,272,140,170,scale,Xoffset,Yoffset) && (SubTab != "weapons")) {
			SubTab = "weapons"; 
			bg_subimage = 0; counter_weapons = 0; incrementor_weapons = 0; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,264,234,140,170,scale,Xoffset,Yoffset) && (SubTab != "armor")) {
			SubTab = "armor"; 
			bg_subimage = 1; counter_armor = 0; incrementor_armor = 0; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,226,196,140,170,scale,Xoffset,Yoffset) && (SubTab != "aid")) {
			SubTab = "aid"; 
			bg_subimage = 2 counter_aid = 0; incrementor_aid = 0; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,188,158,140,170,scale,Xoffset,Yoffset) && (SubTab != "ammo")) {
			SubTab = "ammo"; 
			bg_subimage = 3 counter_ammo = 0; incrementor_ammo = 0; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,150,120,140,170,scale,Xoffset,Yoffset) && (SubTab != "currency")) {
			SubTab = "currency"; bg_subimage = 4; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,112,82,140,170,scale,Xoffset,Yoffset) && (SubTab != "crafting")) {
			SubTab = "crafting"; 
			bg_subimage = 5 counter_crafting = 0; incrementor_crafting = 0; 
			global.Selected = ["none","none"];
			if(instance_exists(MyScrollbar)) {MyScrollbar.reset = 1};
		};
		
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-40,-112,-49,-19,scale,Xoffset,Yoffset) && !MyPlayer.reloading and is_struct(global.Selected[1]) ){
			if(TriButtonText[0] = "Unequip") {UnequipItem(global.Selected[1],global.Selected[0],MyPlayer)};
			if(TriButtonText[0] = "Equip") {EquipItem(global.Selected[1],global.Selected[0],MyPlayer)};
			if(TriButtonText[0] = "Use") {
				ActivateEffect(global.Selected[1],MyPlayer,MyPlayer.BuffList);
				AddItem(global.Selected[1],-1,grd_inv_aidd,InventorySize,global.Selected[0]);
			};
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-122,-216,-19,-49,scale,Xoffset,Yoffset)){
			Description = 1;
		};
		if(ButtonRegionCenter(Mouse_X,Mouse_Y,-223,-280,-19,-49,scale,Xoffset,Yoffset)){
			Drop = 1;
		};

	};
};//click check

/*
//draw rectangles around button regions 
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

#endregion

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


//draw_text(Xcent,Ycent,Tab);