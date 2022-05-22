
function WeaponStructs(){

Boltgun_Phobos = //---------------------------- PHOBOS BOLTER
	{
		//combat stats
		damage : 20,
		ROF : 6,
		range : 1000,
		capacity : 30,		
		spread : 4,
		muzzle_velocity : 30,
		
		//technical weapon stats
		weapon_type : "rifle_bolt",
		weapon_slot : "primary",
		ammo_type: "bolt_small",
		default_ammo_type: 0000000000000000000000000000,
		firemodes: firemode_rifle,
		weight : 15,
		durability_max : 1000,
		rarity : "150.common",
		heat_generation : -1,
		heat_capacity : 0,
		
		//cosmetic stuff, animations, sounds, etc.
		name : "Phobos Pattern Boltgun",
		description : "desc_blank.txt", 
		inventory_subimage : 0, //subimage for item to appear in inventory
		weapon_attachment : "bolter_phobos", //spine attachment name
		magazine_attachment : "mag_bolter_1", //spine attachment name
		flash_type : flash_med_normal,
		animation_group : anmgrp_boltgun_phobos,
		sound_group : sndgrp_boltgun1,
		angular_offset : 22, //angular offset for animation related stuff
		vertical_offset : -150 // Y axis offset for crosshair stuff
		
		
	};
	//ds_list_add(ListComWP,pistol_bolt_tigrus[27]+".pistol_bolt_tigrus") //fix this later
	
};//function end bracket