
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

#region item search function

function SearchForItem(Grid,Keyword,Variable,ArrayKey=0) { //searches grid of items for a specific variable containing a keyword
	
	var Size = ds_grid_width(Grid);
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

function EquipItem(Grid,UniqueID,PlayerID) { //searches grid of items for a specific variable containing a keyword
	
	var ValueY = ds_grid_value_y(Grid,0,0,10,ds_grid_width(Grid),UniqueID);
	var Item = ds_grid_get(Grid,0,ValueY);
	
	var IsWeapon = string_count("weapon",Item.item_type);
	var IsAmmo = string_count("ammo",Item.item_type);
	
	if(IsWeapon) {
		if(Item.weapon_slot[0] = "primary"){
			with(PlayerID) {
				wpn_primary = Item;
				wpn_active = Item;
				wpn_primary_id = UniqueID;
				skeleton_animation_set(Item.animation_group.idle);
				skeleton_attachment_set("slot_gun",Item.weapon_attachment);
				skeleton_attachment_set("slot_gun magazine",Item.magazine_attachment);
			};
		};
		if(Item.weapon_slot[0] = "secondary"){
		};
	};

};

#endregion

#region add item function
function AddItem (Item,Quantity,TargetGrid,InventorySize,Durability=-1){
	
	var Counter = 0;
	var ItemType = "none";
	if(variable_struct_exists(Item,"weapon_type")) {ItemType = "weapon"};
	if(variable_struct_exists(Item,"projectile_type")) {ItemType = "ammo"};
	if(variable_struct_exists(Item,"physical_resist")) {ItemType = "armor"};
	if(variable_struct_exists(Item,"FIX THIS PLEASE")) {ItemType = "aid"};
	if(variable_struct_exists(Item,"FIX THIS PLEASE")) {ItemType = "crafting"};
	
	if(ItemType = "weapon") {
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
	
	if(ItemType = "ammo") {
		
		var GridWidth = ds_grid_width(TargetGrid);
		var ItemY = ds_grid_value_y(TargetGrid,0,0,GridWidth-1,InventorySize-1,Item);
		
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
					break;
				};		
			Counter +=1;
			
			}; //while loop
		}; //else check
	}; //is ammo check
	
};// func end
#endregion

