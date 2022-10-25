

#region Identify Item by type

function IdentifyItem(Item) {
	
	var Type = Item.item_type;
	if(string_count("weapon_ranged",Type)) {return "ranged_weapon"};
	if(string_count("weapon_melee",Type)) {return "melee_weapon"};
	if(string_count("ammo",Type)) {return "ammo"};
	if(string_count("armor",Type)) {return "armor"};
	if(string_count("ingredient",Type)) {return "ingredient"};
	if(string_count("currency",Type)) {return "currency"};
	
	return -1;
};

#endregion

#region item ID generation function

function GenerateID() { //generates a unique ID, given a list of existing IDs
	
	var IDList = global.IDList;
	var Numbers = string(irandom_range(0,10000000)); //10 million possible digits
	var Letters1 = choose("A","B","C","D","E","F");
	var Letters2 = choose("G","H","I","J","K","L");
	
	var ID = Numbers+Letters1+Letters2;
	
	while(ds_list_find_index(IDList,ID) != -1) {
		var Numbers = string(irandom_range(0,10000000)); //10 million possible digits
		var Letters1 = choose("A","B","C","D","E","F");
		var Letters2 = choose("G","H","I","J","K","L");
	
		var ID = Numbers+Letters1+Letters2;
	};	
	
	ds_list_add(IDList,ID);
	return ID;

};

#endregion

#region add item function
function AddItem (Item,Quantity,TargetGrid,InventorySize,Durability=-1){
	
	var Counter = 0;
	var Type = Item.item_type;
	
	if(string_count("weapon_ranged",Type)) {
		while(Counter < (InventorySize-1) ) {
			
			var Slot = ds_grid_get(TargetGrid,0,Counter);				
			if(Slot = 0) {
				ds_grid_set(TargetGrid,0,Counter,Item); //what are we adding?
				ds_grid_set(TargetGrid,1,Counter,Quantity); //how many?
				if(Durability = -1) {Durability = Item.durability_max};
				ds_grid_set(TargetGrid,2,Counter,Durability); //how much durability remaining?
				ds_grid_set(TargetGrid,3,Counter,Item.default_ammo_type); //what is our ammo type? 
				ds_grid_set(TargetGrid,4,Counter,Item.capacity); //rounds left in mag?
				ds_grid_set(TargetGrid,8,Counter,GenerateID()); //unique ID for item
				break;
			};		
			Counter +=1;
		}; //while loop
	};//is weapon check
	
	if(string_count("weapon_melee",Type)) {
		while(Counter < (InventorySize-1) ) {
			
			var Slot = ds_grid_get(TargetGrid,0,Counter);				
			if(Slot = 0) {
				ds_grid_set(TargetGrid,0,Counter,Item); //what are we adding?
				ds_grid_set(TargetGrid,1,Counter,Quantity); //how many?
				if(Durability = -1) {Durability = Item.durability_max};
				ds_grid_set(TargetGrid,2,Counter,Durability); //how much durability remaining?
				//ds_grid_set(TargetGrid,3,Counter,Item.default_ammo_type); //what is our ammo type? 
				//ds_grid_set(TargetGrid,4,Counter,Item.capacity); //rounds left in mag?
				ds_grid_set(TargetGrid,8,Counter,GenerateID()); //unique ID for item
				break;
			};		
			Counter +=1;
		}; //while loop
	};//is weapon check
	
	if(string_count("ammo",Type)) {
		
		var GridHeight = ds_grid_height(TargetGrid);
		var ItemY = ds_grid_value_y(TargetGrid,0,0,GridHeight,InventorySize-1,Item);
		
		if(ItemY != -1) {
			var CurrentQuantity = ds_grid_get(TargetGrid,1,ItemY);
			ds_grid_set(TargetGrid,1,ItemY,CurrentQuantity+Quantity);
			
		};
		else{
		
			while(Counter < (InventorySize-1) ) {
			
				var Slot = ds_grid_get(TargetGrid,0,Counter);				
				if(Slot = 0) {
					ds_grid_set(TargetGrid,0,Counter,Item); //what are we adding?
					ds_grid_set(TargetGrid,1,Counter,Quantity); //how many?
					ds_grid_set(TargetGrid,8,Counter,GenerateID()); //unique ID for item
					if(variable_instance_exists(id,"MyPlayer")){
						if(MyPlayer.ammo_secondary = Item) {MyPlayer.ammo_secondary_id = ds_grid_get(TargetGrid,8,Counter)};
						if(MyPlayer.ammo_primary = Item) {MyPlayer.ammo_primary_id = ds_grid_get(TargetGrid,8,Counter)};
						if(MyPlayer.ammo_active = Item) {MyPlayer.ammo_active_id = ds_grid_get(TargetGrid,8,Counter)};
					};
					break;
				};		
			Counter +=1;
			
			}; //while loop
		}; //else check		
	}; //is ammo check
	
	if(string_count("armor",Type)) {
		while(Counter < (InventorySize-1) ) {
			
			var Slot = ds_grid_get(TargetGrid,0,Counter);				
			if(Slot = 0) {
				ds_grid_set(TargetGrid,0,Counter,Item); //what are we adding?
				ds_grid_set(TargetGrid,1,Counter,Quantity); //how many?
				if(Durability = -1) {Durability = Item.durability_max};
				ds_grid_set(TargetGrid,2,Counter,Durability); //how much durability remaining?
				ds_grid_set(TargetGrid,8,Counter,GenerateID()); //unique ID for item
				break;
			};		
			Counter +=1;
		}; //while loop
	};//is weapon check
	
	
	refresh = 1;
};// func end
#endregion

#region clear item entry function

function ClearItem (UniqueID,TargetGrid,PlayerID){

	if(UniqueID = PlayerID.ammo_primary_id) {PlayerID.ammo_primary_id = -1};
	if(UniqueID = PlayerID.ammo_secondary_id) {PlayerID.ammo_secondary_id = -1};
	if(UniqueID = PlayerID.ammo_active_id) {PlayerID.ammo_active_id = -1};
	if(UniqueID = PlayerID.wpn_primary_id) {PlayerID.wpn_primary_id = -1};
	if(UniqueID = PlayerID.wpn_secondary_id) {PlayerID.wpn_secondary_id = -1};
	if(UniqueID = PlayerID.wpn_melee_id) {PlayerID.wpn_melee_id = -1};
	if(UniqueID = PlayerID.wpn_active_id) {PlayerID.wpn_active_id = -1};
	
	var ItemY = ds_grid_value_y(TargetGrid,0,0,ds_grid_width(TargetGrid),ds_grid_height(TargetGrid),UniqueID);
	ds_grid_set_region(TargetGrid,0,ItemY,ds_grid_width(TargetGrid),ItemY,0);
	
}; //end function bracket

#endregion

#region item search function

function SearchForItem(Grid,Keyword,Variable,ArrayKey=0) { //searches grid of items for a specific variable containing a keyword
	
	var Size = ds_grid_height(Grid);
	var Incrementor = 0;
	
	while(Incrementor < Size) {
		var Item = ds_grid_get(Grid,0,Incrementor);
		var String = 0;
		var Data = variable_struct_get(Item,Variable);
		
		if(is_array(Data)) {String = Data[ArrayKey]} else{String = Data};
		if(string_count(Keyword,String)) {return Incrementor};		
		Incrementor += 1;
	};
	return -1; //we failed to find anything useful

};

#endregion

#region equip items from IC equip button

function EquipItem(Item,UniqueID,PlayerID) { //searches grid of items for a specific variable containing a keyword
	
	var IsRangedWeapon = string_count("weapon_ranged",Item.item_type);
	var IsMeleeWeapon = string_count("weapon_melee",Item.item_type);
	var IsAmmo = string_count("ammo",Item.item_type);
	var IsArmor = string_count("armor",Item.item_type);
		
	#region Ranged weapon swaps
	if(IsRangedWeapon) {
		var Grid = grd_inv_wepn;
		var ValueY = ds_grid_value_y(Grid,0,0,10,InventorySize,UniqueID);
		//logs our ammunition type and rounds left in magazine
		var CurrentValueY = ds_grid_value_y(Grid,0,0,10,InventorySize,PlayerID.wpn_active_id);
		ds_grid_set(Grid,3,CurrentValueY,PlayerID.ammo_active);
		ds_grid_set(Grid,4,CurrentValueY,PlayerID.magazine_active);
		
		//PlayerID.spread_angle = 0; //need this to avoid crashes, for some reason
		
		var _Slot = Item.weapon_slot[0];		
		//if(UniqueID = PlayerID.wpn_primary_id) {exit};
			
		//if we have any of the ammo type currently in the mag of the gun we are switching to, equip it
		var AmmoY = -1;
		var AmmoToSwapTo = ds_grid_get(Grid,3,ValueY);
		if( ds_grid_value_exists(grd_inv_ammo,0,0,10,InventorySize,AmmoToSwapTo) ) {
			var AmmoY = ds_grid_value_y(grd_inv_ammo,0,0,10,InventorySize,AmmoToSwapTo);
		};
		if(AmmoY != -1) {variable_instance_set(MyPlayer,"ammo_"+_Slot+"_id",ds_grid_get(grd_inv_ammo,8,AmmoY))} else{variable_instance_set(MyPlayer,"ammo_"+_Slot+"_id",-1)};
			
			
		with(PlayerID) {			
			var SwapTo = ( (wpn_active = variable_instance_get(id,"wpn_"+_Slot)) or ((wpn_active.weapon_slot[0] = "melee") && (_Slot = "secondary")) );
				
			variable_instance_set(id,"wpn_"+_Slot,Item);
			variable_instance_set(id,"wpn_"+_Slot+"_id",UniqueID);
			variable_instance_set(id,"ammo_"+_Slot,ds_grid_get(Grid,3,ValueY));
			variable_instance_set(id,"magazine_"+_Slot,ds_grid_get(Grid,4,ValueY));
			
			//reset us to fists if we are holding a polearm and equip a pistol
			if(_Slot = "secondary" && (wpn_active_melee.weapon_slot[1] = 2) ) {
				wpn_active_melee = Unarmed_Fists;
				wpn_melee_id = -1;
			}; 
					
			if(SwapTo) {
				wpn_active = Item;
				wpn_active_id = UniqueID;
				ammo_active = variable_instance_get(id,"ammo_"+_Slot);;
				ammo_active_id = variable_instance_get(id,"ammo_"+_Slot+"_id");
				magazine_active = variable_instance_get(id,"magazine_"+_Slot);;
				selector_real = 0;
				selector = wpn_active.firemodes[selector_real];
				skeleton_animation_clear(1); skeleton_animation_clear(5);
				skeleton_animation_set_ext(Item.animation_group.idle,1);
				skeleton_attachment_set("slot_gun",Item.weapon_attachment);
				skeleton_attachment_set("slot_gun magazine",Item.magazine_attachment);
			};
		};		
	};
	#endregion
	
	#region Melee weapon swaps
	if(IsMeleeWeapon) {
		
		var _Hands = Item.weapon_slot[1];
		
		//one handed melee weapons
		if(_Hands = 3) {	
			with(PlayerID) {
				var SwapTo = ( (wpn_active = variable_instance_get(id,"wpn_secondary")) or (wpn_active = variable_instance_get(id,"wpn_active_melee")) );
			
				variable_instance_set(id,"wpn_active_melee",Item);
				variable_instance_set(id,"wpn_melee_id",UniqueID);
				//if(wpn_secondary = Unarmed_Fists) {wpn_secondary = Item};
				wpn_secondary = Item;
				wpn_secondary_id = UniqueID;
					
				if(SwapTo) {
					
					skeleton_attachment_set("slot_gun",-1);	
					wpn_active = Item;//Unarmed_Fists;
					wpn_active_id = UniqueID;
					variable_instance_set(id,"wpn_active_melee",Item);
					variable_instance_set(id,"wpn_melee_id",UniqueID);
					variable_instance_set(id,"wpn_secondary",Item);
					variable_instance_set(id,"wpn_secondary_id",UniqueID);
					variable_instance_set(id,"ammo_secondary",-1);
					variable_instance_set(id,"ammo_secondary_id",-1);
					skeleton_animation_set_ext(Item.animation_group.idle,1);
										
					skeleton_animation_clear(1); skeleton_animation_clear(5);					
					skeleton_animation_set_ext(Item.animation_group.idle,5);
					skeleton_animation_set_ext(Item.animation_group.idle,1);
					skeleton_attachment_set("slot_melee_weapon",Item.weapon_attachment);													
				};//swapto check
			};//with playerid
		};//3 handed check
			
		//two handed melee weapons
		if(_Hands = 2) {	
			
			var SwapTo = ( (PlayerID.wpn_active = PlayerID.wpn_secondary) or (PlayerID.wpn_active = PlayerID.wpn_active_melee) );
			
			//log our secondary ammo if we equip a 2 handed melee weapon
			if(string_count("weapon_ranged",PlayerID.wpn_secondary.item_type)){
				var CurrentValueY = ds_grid_value_y(grd_inv_wepn,0,0,10,InventorySize,PlayerID.wpn_secondary_id);
				ds_grid_set(grd_inv_wepn,3,CurrentValueY,PlayerID.ammo_secondary);
				
				var Mag_Cap = PlayerID.magazine_secondary;
				if(SwapTo) {Mag_Cap = PlayerID.magazine_active};
				ds_grid_set(grd_inv_wepn,4,CurrentValueY,Mag_Cap);
			};
					
			with(PlayerID) {
				variable_instance_set(id,"wpn_active_melee",Item);
				variable_instance_set(id,"wpn_melee_id",UniqueID);
				variable_instance_set(id,"wpn_secondary",Item);
				variable_instance_set(id,"wpn_secondary_id",UniqueID);
				variable_instance_set(id,"ammo_secondary",-1);
				variable_instance_set(id,"ammo_secondary_id",-1);
					
				if(SwapTo) {
					wpn_active = Item;
					wpn_active_id = UniqueID;
					ammo_active = -1;
					ammo_active_id = -1;
					magazine_active = 0;
					selector_real = 0;
					skeleton_animation_clear(1); skeleton_animation_clear(5);
					skeleton_animation_set_ext(Item.animation_group.idle,1);
					skeleton_attachment_set("slot_gun",Item.weapon_attachment);
					skeleton_attachment_set("slot_gun magazine",-1);
				}; //swap to check
			}; //with player
		}; //2 hands check
	};//melee weapon check
	#endregion
	
	#region Ammo Swaps
	if(IsAmmo) {
		
		var ActiveWeapon = MyPlayer.wpn_active;
		var IsValid = string_count("weapon_ranged",ActiveWeapon.item_type);
		var CorrectAmmo = (Item.item_type = ActiveWeapon.ammo_type);
		var NotTheSame = (Item != MyPlayer.ammo_active);
		
		if(NotTheSame && IsValid && CorrectAmmo && !MyPlayer.reloading){
			
			var GunY = ds_grid_value_y(grd_inv_wepn,0,0,ds_grid_width(grd_inv_wepn),ds_grid_height(grd_inv_wepn),MyPlayer.wpn_active_id);
			ds_grid_set(grd_inv_wepn,3,GunY,Item);
			
			if(MyPlayer.wpn_active.weapon_slot[0] = "primary") {MyPlayer.ammo_primary = Item; MyPlayer.ammo_primary_id = UniqueID};
			if(MyPlayer.wpn_active.weapon_slot[0] = "secondary") {MyPlayer.ammo_secondary = Item; MyPlayer.ammo_secondary_id = UniqueID};
				
			MyPlayer.ammo_active = Item; MyPlayer.ammo_active_id = UniqueID;
			
			with (MyPlayer) {				
				magazine_active = 0;
				burst_count = 0;
				reloading = 1;
				skeleton_animation_clear(3); skeleton_animation_clear(3);
				skeleton_animation_clear(4); skeleton_animation_clear(5);		
				skeleton_animation_clear(6); skeleton_animation_clear(8);
		
				if(is_array(wpn_active.animation_group.reload)) {skeleton_animation_set_ext(wpn_active.animation_group.reload[0],4)};
				else{skeleton_animation_set_ext(wpn_active.animation_group.reload,4)};			
			};
		};
		
	};
	#endregion
	
	#region armor equiping
	if(IsArmor) {
		var Grid = grd_inv_armr;		
		var VarString = -1; //string for the variable to change in the player object
		
		if(string_count("head",Item.item_type)) {VarString = "armor_head"};
		else if(string_count("torso",Item.item_type)) {VarString = "armor_torso"};
		else if(string_count("armL",Item.item_type)) {VarString = "armor_armL"};
		else if(string_count("armR",Item.item_type)) {VarString = "armor_armR"};
		else if(string_count("legL",Item.item_type)) {VarString = "armor_legL"};
		else if(string_count("legR",Item.item_type)) {VarString = "armor_legR"};
		
		var ItemDurability = ds_grid_get(Grid,2,ds_grid_value_y(Grid,0,0,ds_grid_width(Grid),ds_grid_height(Grid),UniqueID));
		var ItemMaxDurability = Item.durability_max;
		var Array = variable_instance_get(PlayerID,VarString); //set the armor item 
		Array[0] = Item;
		Array[1] = UniqueID;
		Array[2] = clamp(ItemDurability/ItemMaxDurability,0.2,1);
		variable_instance_set(PlayerID,VarString,Array); //set the unique ID for the item
		
		with(PlayerID) {						
			if(VarString = "armor_head"){
				skeleton_attachment_set("slot_head" , Item.armor_attachment[0]); 
				skeleton_attachment_set("slot_eyes" , Item.armor_attachment[1]);	
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_head = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
			else if(VarString = "armor_torso"){
				skeleton_attachment_set("slot_torso" , Item.armor_attachment[0]); 
				skeleton_attachment_set("slot_collar" ,  Item.armor_attachment[1]);
				skeleton_attachment_set("slot_backpack" ,  Item.armor_attachment[2]);
				skeleton_attachment_set("slot_backpack trim" ,  Item.armor_attachment[3]);
				skeleton_attachment_set("slot_pelvis" ,  Item.armor_attachment[4]);
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_torso = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
			else if(VarString = "armor_armL"){				
				skeleton_attachment_set("slot_front bicep" , Item.armor_attachment[0]);  
				skeleton_attachment_set("slot_front forearm" ,Item.armor_attachment[1]);
				skeleton_attachment_set("slot_pauldron" , Item.armor_attachment[2]);  
				skeleton_attachment_set("slot_pauldron trim" , Item.armor_attachment[3]); 
				skeleton_attachment_set("slot_front hand", Item.armor_attachment[4]);
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_armL = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
			else if(VarString = "armor_armR"){
				skeleton_attachment_set("slot_rear bicep" , Item.armor_attachment[0]); 
				skeleton_attachment_set("slot_rear forearm" , Item.armor_attachment[1]);
				skeleton_attachment_set("slot_rear pauldron" , Item.armor_attachment[2]);
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_armR = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
			else if(VarString = "armor_legL"){
				skeleton_attachment_set("slot_front thigh" , Item.armor_attachment[0]);  
				skeleton_attachment_set("slot_front thigh_trim1" , Item.armor_attachment[1]); 
				skeleton_attachment_set("slot_front knee" , Item.armor_attachment[2]);  
				skeleton_attachment_set("slot_front shin" , Item.armor_attachment[3]);  
				skeleton_attachment_set("slot_front foot" , Item.armor_attachment[4]);
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_legL = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
			else if(VarString = "armor_legR"){
				skeleton_attachment_set("slot_rear thigh" , Item.armor_attachment[0]);  
				skeleton_attachment_set("slot_rear knee" , Item.armor_attachment[1]); 
				skeleton_attachment_set("slot_rear shin" , Item.armor_attachment[2]); 
				skeleton_attachment_set("slot_rear foot" , Item.armor_attachment[3]);	
				var DRatio = clamp(ItemDurability/ItemMaxDurability,0.2,1);
				var PHYS = (Item.rPHYS + 0)*DRatio;
				var THER = (Item.rTHER + 0)*DRatio;
				var CRYO = (Item.rCRYO + 0)*DRatio;
				var CORR = (Item.rCORR + 0)*DRatio;
				var RADI = (Item.rRADI + 0)*DRatio;
				var ELEC = (Item.rELEC + 0)*DRatio;
				var HAZM = (Item.rHAZM + 0)*DRatio;
				var WARP = (Item.rWARP + 0)*DRatio;	
				
				resist_legR = [PHYS,THER,CRYO,CORR,RADI,ELEC,HAZM,WARP];
			};
						
		};
	};		
	#endregion
}; //equip item function end bracket

#endregion

#region DS grid alphabetizer function unmodified

function scr_grid_alphabetize(grid,TitleIndex,IDIndex=9){ //feed grid to organize, array key to get name string, and what grid value to pull uniqueID from
	
	var Counter = 0;
	
	var Width = ds_grid_width(grid);
	var Length = ds_grid_height(grid);
	var TitleList = ds_list_create();
	var StatsList = ds_list_create();
	var TempGrid = ds_grid_create(Width,Length);
	var TitleIndexInternal = TitleIndex;
	
//---------------------------------------------- ADD STUFF TO LISTS ---------------------------------

	while(Counter < Width) {
		var Item = ds_grid_get(grid,Counter,0)
		if(Item != 0){
			switch(Item[22]){
				case "grenade": TitleIndexInternal = 6; break;
				case "melee": TitleIndexInternal = 14; break;
				default: TitleIndexInternal = TitleIndex; break;
			};
			var Title = Item[TitleIndexInternal]+string(ds_grid_get(grid,Counter,IDIndex));
			ds_list_add(TitleList,Title);
			ds_list_sort(TitleList,true);

			Counter+=1;
		}
		else Counter+=1;	
	}
	
	Counter = 0;
	
	while(Counter < Width) {
		var Item = ds_grid_get(grid,Counter,0);
		if(Item != 0){
		switch(Item[22]){
				case "grenade": TitleIndexInternal = 6; break;
				case "melee": TitleIndexInternal = 14; break;
				default: TitleIndexInternal = TitleIndex; break;
			};
		var Title = Item[TitleIndexInternal]+string(ds_grid_get(grid,Counter,IDIndex));
		
		var array = array_create(Length);
			for(var i = 0; i<array_length(array); i++){
				array[i] = ds_grid_get(grid,Counter,i);
			};	
			
		var Index = ds_list_find_index(TitleList,Title);
		ds_list_set(StatsList,Index,array);

		Counter+=1;
		};
		else Counter+=1;
	};
	
	Counter = 0;
	
	while(Counter < ds_list_size(StatsList)) {
		var Entry = ds_list_find_value(StatsList,Counter);
		for(var i = 0; i<array_length(Entry); i++){
				ds_grid_set(TempGrid,Counter,i,Entry[i]);
			};	
		
		Counter+=1;
	};
	
//------------------------------------------ RETURN STUFF ---------------------------------

ds_list_destroy(TitleList);
ds_list_destroy(StatsList);
ds_grid_copy(grid,TempGrid); //Ds grid copy overwrite existing grid with the one we generated
ds_grid_destroy(TempGrid);
};

#endregion

#region DS grid alphabetizer function

function ds_grid_alphabetize(grid,IDIndex=8){//feed grid to organize and what grid value to pull uniqueID from
	
	var Counter = 0;
	
	var Width = ds_grid_width(grid);
	var Length = ds_grid_height(grid);
	var TitleList = ds_list_create();
	var StatsList = ds_list_create();
	var TempGrid = ds_grid_create(Width,Length);
	//var TitleIndexInternal = TitleIndex;
	
//---------------------------------------------- ADD STUFF TO LISTS ---------------------------------

	while(Counter < Length) {
		var Item = ds_grid_get(grid,0,Counter)
		if(Item != 0){
			
			var Title = Item.name+string(ds_grid_get(grid,IDIndex,Counter));
			ds_list_add(TitleList,Title);
			ds_list_sort(TitleList,true);

			Counter+=1;
		}
		else Counter+=1;	
	}
	
	Counter = 0;
	
	while(Counter < Length) {
		var Item = ds_grid_get(grid,0,Counter);
		if(Item != 0){
		
		var Title = Item.name+string(ds_grid_get(grid,IDIndex,Counter));
		
		var array = array_create(Width);
			for(var i = 0; i<array_length(array); i++){
				array[i] = ds_grid_get(grid,i,Counter);
			};	
			
		var Index = ds_list_find_index(TitleList,Title);
		ds_list_set(StatsList,Index,array);

		Counter+=1;
		};
		else Counter+=1;
	};
	
	Counter = 0;
	
	while(Counter < ds_list_size(StatsList)) {
		var Entry = ds_list_find_value(StatsList,Counter);
		for(var i = 0; i<array_length(Entry); i++){
				ds_grid_set(TempGrid,i,Counter,Entry[i]);
			};	
		
		Counter+=1;
	};
	
//------------------------------------------ RETURN STUFF ---------------------------------

ds_list_destroy(TitleList);
ds_list_destroy(StatsList);
ds_grid_copy(grid,TempGrid); //Ds grid copy overwrite existing grid with the one we generated
ds_grid_destroy(TempGrid);
};

#endregion
