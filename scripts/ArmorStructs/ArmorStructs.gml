
function ArmorStructs(){

	#region mk2 crusade armor
	
	Armor_Head_2000 = { //---------------------------- Standard MK2 helmet
		
		item_type : "power_armor_head",
		
		weight : 20, //weight in lbs
		durability_max : 300,
		rarity : "1350.common",	
		
		heat_generation : 5, //heat and armor generation 
		heat_capacity : 50, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
					
		sensor_range : 2400, //effective range of directional sensors
		sensor_cone : 60, //sensor cone total width
		
		rPHYS : 40, //physical damage resist
		rTHER : 50, //thermal damage resist
		rCRYO : 25, //cryo damage resist
		rCORR : 45, //corrosive damage resist
		rRADI : 25, //radioactive damage resist
		rELEC : 25, //electrical damage resist
		rHAZM : 100, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 3, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Helmet",
		armor_attachment : ["2000_head","2000_eyes"],	
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	
	Armor_Torso_2000 = { //---------------------------- Standard MK2 Torso
		
		item_type : "power_armor_torso",
		
		weight : 110, //weight in lbs
		durability_max : 1000,
		rarity : "1350.common",	
		
		heat_generation : 25, //heat and armor generation 
		heat_capacity : 2500, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
		
		sensor_range : 800, //range for omnidirectional sensors
		
		rPHYS : 75, //physical damage resist
		rTHER : 85, //thermal damage resist
		rCRYO : 35, //cryo damage resist
		rCORR : 55, //corrosive damage resist
		rRADI : 45, //radioactive damage resist
		rELEC : 45, //electrical damage resist
		rHAZM : 85, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 12, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Cuirass",
		armor_attachment : ["2000_torso","2000_collar","2000_backpack","2000_backpack trim","2000_pelvis"],	
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	
	Armor_ArmL_2000 = { //---------------------------- Standard MK2 Left Arm
		
		item_type : "power_armor_armL",
		
		weight : 40, //weight in lbs
		durability_max : 400,
		rarity : "1350.common",	
		
		heat_generation : 8, //heat and armor generation 
		heat_capacity : 80, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
		
		rPHYS : 60, //physical damage resist
		rTHER : 60, //thermal damage resist
		rCRYO : 22, //cryo damage resist
		rCORR : 35, //corrosive damage resist
		rRADI : 22, //radioactive damage resist
		rELEC : 22, //electrical damage resist
		rHAZM : 40, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 5, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Left Vambrace",
		armor_attachment : ["front bicep","2000_front forearm","pauldron","2000_pauldron trim","front hand"],	
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	
	Armor_ArmR_2000 = { //---------------------------- Standard MK2 Right Arm
		
		item_type : "power_armor_armR",
		
		weight : 40, //weight in lbs
		durability_max : 400,
		rarity : "1350.common",	
		
		heat_generation : 8, //heat and armor generation 
		heat_capacity : 80, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
		
		rPHYS : 60, //physical damage resist
		rTHER : 60, //thermal damage resist
		rCRYO : 22, //cryo damage resist
		rCORR : 35, //corrosive damage resist
		rRADI : 22, //radioactive damage resist
		rELEC : 22, //electrical damage resist
		rHAZM : 40, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 5, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Right Vambrace",
		//armor_attachment : ["front bicep","2000_front forearm","pauldron","2000_pauldron trim"],	
		armor_attachment : ["rear bicep","rear forearm","rear pauldron"],	
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	
	Armor_LegL_2000 = { //---------------------------- Standard MK2 Left Leg
		
		item_type : "power_armor_legL",
		
		weight : 60, //weight in lbs
		durability_max : 700,
		rarity : "1350.common",	
		
		heat_generation : 12, //heat and armor generation 
		heat_capacity : 120, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
		
		rPHYS : 65, //physical damage resist
		rTHER : 65, //thermal damage resist
		rCRYO : 30, //cryo damage resist
		rCORR : 40, //corrosive damage resist
		rRADI : 30, //radioactive damage resist
		rELEC : 30, //electrical damage resist
		rHAZM : 40, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 8, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Left Greave",
		armor_attachment : ["2000_thigh","2000_thigh_trim","2000_knee","2000_shin","2000_foot"],	
		
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	
	Armor_LegR_2000 = { //---------------------------- Standard MK2 Left Leg
		
		item_type : "power_armor_legR",
		
		weight : 60, //weight in lbs
		durability_max : 700,
		rarity : "1350.common",	
		
		heat_generation : 12, //heat and armor generation 
		heat_capacity : 120, //overheat capacity
		cooling_rate : 1, //cooling rate modifier, as portion of heat generation
		
		rPHYS : 65, //physical damage resist
		rTHER : 65, //thermal damage resist
		rCRYO : 30, //cryo damage resist
		rCORR : 40, //corrosive damage resist
		rRADI : 30, //radioactive damage resist
		rELEC : 30, //electrical damage resist
		rHAZM : 40, //hazmat damage resist
		rWARP : 0,  //warp damage resist
		
		poise : 8, //resistance to knockback and impact stunlock
		
		name : "MKII 'Crusade' Pattern Right Greave",
		armor_attachment : ["2000_thigh","2000_knee","2000_shin","2000_foot"],
		
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6] //subimage for item to appear in inventory		
	};
	#endregion
	
};