
#region consumable structs

function ConsumableStructs(){
	
	#region Combat Drugs
		Drug_Combat_Somatogen = { //---------------------------- somatogen
		
		item_type : "consumable_med_drug_combat",
		
		//buff related stats
		item_effects : [ ["buff","END",20,1200], ["per/sec","HP",0.25,600], ["instant","HP",100,1] ],
		
		//technical weapon stats
		weight : 0.01,
		rarity : "100.common",
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Somatogen",
		description : "desc_blank.txt", 
		use_sound : -1,		
		inventory_subimage : [sp_xhair, 6],
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
	#endregion

};

#endregion

#region  buff-related functions

function ActivateEffect(Item,ID,BuffDSList) {	//-------------------------- effect activation 
			
	var ItemEffectArray = Item.item_effects;
	var ItemEffectCount = array_length(ItemEffectArray);
	var i = 0;
	
	while(i <= (ItemEffectCount-1)) {
		var EffectArray = ItemEffectArray[i];	
		var EffectType = EffectArray[0];
		var EffectVariable = EffectArray[1];
		var EffectStrength = EffectArray[2];
		var EffectDuration = EffectArray[3];
		var ArrayToAdd = [EffectType,EffectVariable,EffectStrength,timer_create(EffectDuration,0)];
		ds_list_add(BuffDSList,ArrayToAdd);
		
		if(EffectType = "buff"){
			var StatStruct = variable_instance_get(id,"Mod");
			var CurrentValue = variable_struct_get(StatStruct,EffectVariable);
			var NewValue = CurrentValue + EffectStrength;
			variable_struct_set(StatStruct,EffectVariable,NewValue);
		};
		if(EffectType = "instant"){
			var CurrentValue = variable_instance_get(ID,EffectVariable);
			var NewValue = CurrentValue + EffectStrength;
			variable_instance_set(ID,EffectVariable,NewValue);
		};
		
		i++;
	};
};


function TickEffect(BuffDSList) { //-------------------------- effect step ticking event
	
	var ListSize = ds_list_size(BuffDSList);
	var i = 0;

	while(i<ListSize) {
		var Entry = ds_list_find_value(BuffDSList,i);
		if(is_array(Entry)) {
	
			var EffectType = Entry[0];
			var EffectVariable = Entry[1];
			var EffectStrength = Entry[2];
			var Timer = Entry[3];
			
			if(EffectType = "per/sec") {
				var CurrentValue = variable_instance_get(id,EffectVariable);
				var NewValue = CurrentValue + EffectStrength;
				variable_instance_set(id,EffectVariable,NewValue);
			};
			
			var Trigger = timer_tick(Timer,0);
			if(Trigger) {
				ds_list_delete(BuffDSList,i);			
				
				if(EffectType = "buff"){
					var StatStruct = variable_instance_get(id,"Mod");
					var CurrentValue = variable_struct_get(StatStruct,EffectVariable);
					var NewValue = CurrentValue - EffectStrength;
					variable_struct_set(StatStruct,EffectVariable,NewValue);
				};
				
			};
		};
		i++;
	};
};

#endregion