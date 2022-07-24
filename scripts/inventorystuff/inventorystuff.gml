
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
function AddItem (Item,Quantity,TargetGrid,Durability=-1){
	
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
	
};// func end
#endregion

#region inventory item surface drawing function

function DrawItemUIPart(surface,scale,originX,originY,displacement) {
	
	if(!surface_exists(surface)) {surface_create(313,36)};
	
	surface_set_target(surface);
    draw_clear_alpha(c_black, 0);	
	draw_surface_general(surface, 0, 0, surface_get_width(surface), displacement, originX, originY, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
	
    
	
};

#endregion