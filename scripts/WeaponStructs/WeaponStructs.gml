

#region Find ROF Function
function FindROF(RoundsPerMinute) {
	var  time = ( 1000/(RoundsPerMinute/60) )/16.7;
	return time;
}; // find ROF end
#endregion

#region WeaponStructs function
function WeaponStructs(){

	#region fists
	Unarmed_Fists = { //---------------------------- thunderedge pattern chainsword
		
		item_type : "weapon_melee_unarmed",
		
		//combat stats
		damage : 0,
		force : 10, //poise and guard break
		penetration : 0, //armor penetration, as percent of damage
		scalings : ["STR(D).100","DEX(E).50"], //scalings for damage bonus to stats
		damage_type : ["physical.100"],
		
		//technical weapon stats
		weapon_type : "unarmed_fists",
		weapon_slot : ["melee",2], //1 = single hand, 2 = both hands, 3 = offhand,
		weight : 0,
		durability_max : "none",
		rarity : "100.common",
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Fists",
		weapon_attachment : -1, //spine attachment name
		animation_group : anmgrp_fists,
		sound_group : sndgrp_unarmed1
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
	#endregion
	
	#region Boltguns, storm bolters, bolt pistols and heavy bolters
Boltgun_Phobos = { //---------------------------- PHOBOS BOLTER
		
		item_type : "weapon_ranged_bolt",
		
		//combat stats
		damage : 65, //65
		ROF : FindROF(450), //rounds per minute
		range : 4000, //effective range before gravity takes hold, rounds can mod this
		capacity : 30,		
		spread : 0.2,
		muzzle_velocity : 70,
		
		//technical weapon stats
		weapon_type : "rifle_bolt",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_bolt",
		default_ammo_type: Ammo_Bolt_Standard,
		firemodes: ["Semi","Burst (3)","Auto"],
		weight : 15,
		durability_max : 1000,
		rarity : "1300.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Phobos Pattern Boltgun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_boltgun_icons, 0], //subimage for item to appear in inventory
		weapon_attachment : "bolter_phobos", //spine attachment name
		magazine_attachment : "mag_sickle1", //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [make_colour_rgb(255, 230, 90), c_white], 
		animation_group : anmgrp_boltgun_phobos,
		sound_group : sndgrp_boltgun1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
	
	Bolt_Pistol_Tigrus = { //---------------------------- tigrus bolt pistol
		
		item_type : "weapon_ranged_bolt",
		
		//combat stats
		damage : 50,
		ROF : FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 10,		
		spread : 0.9,
		muzzle_velocity : 30,
		
		//technical weapon stats
		weapon_type : "pistol_bolt",
		weapon_slot : ["secondary",1], //1 = single hand, 2 = both hands, 3 = offhand
		ammo_type: "ammo_bolt",
		default_ammo_type: Ammo_Bolt_Standard,
		firemodes: ["Semi"],
		weight : 6,
		durability_max : 1000,
		rarity : "1200.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Tigrus Pattern Bolt Pistol",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "pistol_bolt_tigrus", //spine attachment name
		magazine_attachment : "mag_pistol_tigrus", //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [make_colour_rgb(255, 230, 90), c_white], 
		animation_group : anmgrp_boltpistol_tigrus,
		sound_group : sndgrp_boltgun2,
		angular_offset : 150, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion

	#region Melta weapons and inferno pistols
Meltagun_Proteus = { //---------------------------- proteus melter
		
		item_type : "weapon_ranged_melta",
		
		//combat stats
		damage : 90,
		ROF : 2, //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 55,		
		spread : 0.1,
		muzzle_velocity : 00,
		
		//technical weapon stats
		weapon_type : "melta",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_melta",
		default_ammo_type: Ammo_Melta_Standard,
		firemodes: ["Auto"],
		weight : 18,
		durability_max : 1000,
		rarity : "1200.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Proteus Pattern Meltagun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "meltagun_proteus", //spine attachment name
		magazine_attachment : "mag_melta_proteus", //spine attachment name
		flash_type : flash_med_melta,
		flash_color : [c_orange, c_white], 
		animation_group : anmgrp_meltagun_proteus,
		sound_group : sndgrp_melta1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion	
	
	#region Flamers, hand flamers, heavy flamers
Flamer_Astartes = { //---------------------------- ASTARTES SHOTGUN
	
		item_type : "weapon_ranged_flamer",
		
		//combat stats
		damage : 20,
		ROF : 3, //FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 75,		
		spread : 0.1,
		muzzle_velocity : 21,
		
		//technical weapon stats
		weapon_type : "flamer",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_flamer",
		default_ammo_type: Ammo_Flamer_Standard,
		firemodes: ["Auto"],
		weight : 18,
		durability_max : 1000,
		rarity : "400.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Astartes Pattern Flamer",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "flamer_astartes", //spine attachment name
		magazine_attachment : "mag_flamer_1", //spine attachment name
		flash_type : "none",
		flash_color : "none", 
		animation_group : anmgrp_flamer_astartes,
		sound_group : sndgrp_flamer1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion	
	
	#region Laser locks, guns, cutters, cannons, etc.
Lasgun_Kantrael = { //---------------------------- KANTRAEL LASGUN
		
		item_type : "weapon_ranged_laser_lasgun",
		
		//combat stats
		damage : 42,
		ROF : FindROF(250), //rounds per minute
		range : 4000, //effective range before gravity takes hold, rounds can mod this
		capacity : 60,		
		spread : 2,
		muzzle_velocity : 0,//0,
		
		//technical weapon stats
		weapon_type : "rifle_laser",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_laser_small",
		default_ammo_type: Ammo_Laser_Pack_Standard,
		firemodes: ["Semi","Auto"],
		weight : 7,
		durability_max : 3000,
		rarity : "300.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Kantrael Pattern Lasgun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_boltgun_icons, 0], //subimage for item to appear in inventory
		weapon_attachment : "bolter_phobos", //spine attachment name
		magazine_attachment : "mag_sickle1", //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [c_red, c_white], 
		animation_group : anmgrp_boltgun_phobos,
		sound_group : sndgrp_boltgun1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion	

	#region Shotguns, auto and stub weapons
Shotgun_Astartes = { //---------------------------- ASTARTES SHOTGUN
		
		item_type : "weapon_ranged_shotgun",
		
		//combat stats
		damage : 90,
		ROF : 45, //FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 8,		
		spread : 0.25,
		muzzle_velocity : 80,
		
		//technical weapon stats
		weapon_type : "shotgun",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_shotgun",
		default_ammo_type: Ammo_Shotgun_Buckshot,
		firemodes: ["Pump"],
		weight : 10,
		durability_max : 1000,
		rarity : "300.common",
		heat_generation : -1,
		heat_capacity : 1,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Astartes Pattern Shotgun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_shotgun_icons, 0], //subimage for item to appear in inventory
		weapon_attachment : "shotgun_astartes", //spine attachment name
		magazine_attachment : -1, //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [make_colour_rgb(255, 230, 90), c_white], 
		animation_group : anmgrp_shotgun_astartes,
		sound_group : sndgrp_shotgun1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion	

	#region Plasma cannons, guns, pistols
Plasmagun_Thunderbolt = { //---------------------------- Thunderbolt pattern plasma gun
		
		item_type : "weapon_ranged_plasma",
		
		//combat stats
		damage : 120,
		ROF : FindROF(400), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 18,		
		spread : 0.5,
		muzzle_velocity : 28,
		
		//technical weapon stats
		weapon_type : "rifle_plasma",
		weapon_slot : ["primary",2], //1 = single hand, 2 = both hands, 3 = offhand,
		ammo_type: "ammo_plasma",
		default_ammo_type: Ammo_Plasma_Standard,
		firemodes: ["Auto","Overcharge","Charge"],
		weight : 20,
		durability_max : 1000,
		rarity : "1400.common",
		heat_generation : 4,
		heat_capacity : 15, //26
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Thunderbolt Pattern Plasma Gun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "plasmagun_thunderbolt", //spine attachment name
		magazine_attachment : "mag_plasma_thunderbolt", //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [make_colour_rgb(0, 198, 229), c_white], 
		animation_group : anmgrp_plasmagun_thunderbolt,
		sound_group : sndgrp_plasma1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion

	#region Chain swords and axes
Chainsword_Thunderedge = { //---------------------------- thunderedge pattern chainsword
		
		item_type : "weapon_melee_sword_chain",
		
		//combat stats
		damage : 60,
		force : FindROF(330), //poise and guard break
		penetration : 0.3, //armor penetration, as percent of damage
		scalings : ["STR(D).030","DEX(E).020"], //scalings for damage bonus to stats
		damage_type : ["physical.100"],
		
		//technical weapon stats
		weapon_type : "melee_chain_sword",
		weapon_slot : ["melee",3], //1 = single hand, 2 = both hands, 3 = offhand,
		weight : 20,
		durability_max : 600,
		rarity : "500.common",
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Thunderedge Pattern Chainsword",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "sword_chain_thunderedge", //spine attachment name
		animation_group : anmgrp_chainsword_thunderedge,
		sound_group : sndgrp_chain1,
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion
	
	#region Power swords, mauls and axes
Powersword_Proteus = { //---------------------------- thunderedge pattern chainsword
		
		item_type : "weapon_melee_sword_power",
		
		//combat stats
		damage : 50,
		force : FindROF(330), //poise and guard break
		penetration : 1, //armor penetration, as percent of damage
		scalings : ["STR(D).030","DEX(E).020"], //scalings for damage bonus to stats
		damage_type : ["physical.100"],
		
		//technical weapon stats
		weapon_type : "melee_chain_sword",
		weapon_slot : ["melee",3], //1 = single hand, 2 = both hands, 3 = offhand,
		weight : 20,
		durability_max : 600,
		rarity : "900.common",
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Thunderedge Pattern Chainsword",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "bolter_phobos", //spine attachment name
		animation_group : anmgrp_boltgun_phobos,
		sound_group : sndgrp_boltgun1,
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
	
	HeavyHammer_Proteus = { //---------------------------- thunderedge pattern chainsword
		
		item_type : "weapon_melee_heavyhammer_power",
		
		//combat stats
		damage : 120,
		force : 30, //poise and guard break
		penetration : 1, //armor penetration, as percent of damage
		scalings : ["STR(S).100","DEX(F).010"], //scalings for damage bonus to stats
		damage_type : ["physical.100"],
		
		//technical weapon stats
		weapon_type : "melee_power_hammer",
		weapon_slot : ["melee",2], //1 = single hand, 2 = both hands, 3 = offhand,
		weight : 20,
		durability_max : 600,
		rarity : "900.common",
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Proteus Pattern Heavy Thunderhammer",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "heavyhammer_proteus", //spine attachment name
		animation_group : anmgrp_polearm1,
		sound_group : sndgrp_melee_heavy1,
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion

};//weapon structs function end bracket
#endregion