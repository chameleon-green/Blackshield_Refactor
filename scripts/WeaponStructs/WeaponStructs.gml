#region Find ROF Function
function FindROF(RoundsPerMinute) {
	var  time = ( 1000/(RoundsPerMinute/60) )/16.7;
	return time;
}; // find ROF end
#endregion

function WeaponStructs(){

#region Boltguns, storm bolters, bolt pistols and heavy bolters
Boltgun_Phobos = { //---------------------------- PHOBOS BOLTER
	
		//combat stats
		damage : 50,
		ROF : FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 30,		
		spread : 0.3,
		muzzle_velocity : 30,
		
		//technical weapon stats
		weapon_type : "rifle_bolt",
		weapon_slot : "primary",
		ammo_type: "bolt_small",
		default_ammo_type: Ammo_Bolt_Standard,
		firemodes: ["Semi","Auto","Charge"],
		weight : 15,
		durability_max : 1000,
		rarity : "150.common",
		heat_generation : -1,
		heat_capacity : 0,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Phobos Pattern Boltgun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
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
#endregion

#region Flamers, hand flamers, heavy flamers
Flamer_Astartes = { //---------------------------- ASTARTES SHOTGUN
	
		//combat stats
		damage : 20,
		ROF : 2, //FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 75,		
		spread : 0.1,
		muzzle_velocity : 12,
		
		//technical weapon stats
		weapon_type : "flamer",
		weapon_slot : "primary",
		ammo_type: "fuel",
		default_ammo_type: Ammo_Flamer_Standard,
		firemodes: ["Auto"],
		weight : 18,
		durability_max : 1000,
		rarity : "150.common",
		heat_generation : -1,
		heat_capacity : 0,
		
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

#region Shotguns, auto and stub weapons
Shotgun_Astartes = { //---------------------------- ASTARTES SHOTGUN
	
		//combat stats
		damage : 80,
		ROF : 45, //FindROF(330), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 8,		
		spread : 0.5,
		muzzle_velocity : 60,
		
		//technical weapon stats
		weapon_type : "shotgun",
		weapon_slot : "primary",
		ammo_type: "shotgun",
		default_ammo_type: Ammo_Shotgun_Buckshot,
		firemodes: ["Pump"],
		weight : 10,
		durability_max : 1000,
		rarity : "150.common",
		heat_generation : -1,
		heat_capacity : 0,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Astartes Pattern Shotgun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
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
	
		//combat stats
		damage : 100,
		ROF : FindROF(400), //rounds per minute
		range : 1000, //effective range before gravity takes hold, rounds can mod this
		capacity : 18,		
		spread : 0.5,
		muzzle_velocity : 28,
		
		//technical weapon stats
		weapon_type : "rifle_plasma",
		weapon_slot : "primary",
		ammo_type: "plasma",
		default_ammo_type: Ammo_Plasma_Standard,
		firemodes: ["Semi","Auto","Charge"],
		weight : 20,
		durability_max : 1000,
		rarity : "150.common",
		heat_generation : -1,
		heat_capacity : 0,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Thunderbolt Pattern Plasma Gun",
		description : "desc_blank.txt", 
		inventory_subimage : [sp_xhair, 6], //subimage for item to appear in inventory
		weapon_attachment : "plasmagun_thunderbolt", //spine attachment name
		magazine_attachment : "mag_plasma1", //spine attachment name
		flash_type : flash_med_normal,
		flash_color : [make_colour_rgb(0, 198, 229), c_white], 
		animation_group : anmgrp_plasmagun_thunderbolt,
		sound_group : sndgrp_plasma1,
		angular_offset : 90, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
#endregion

};//function end bracket