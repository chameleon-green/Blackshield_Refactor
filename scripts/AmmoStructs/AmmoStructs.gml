// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AmmoStructs() {
	#region small bolt rounds
	Ammo_Bolt_Standard = { //---------------------------- STANDARD BOLT ROUNDS
		
		item_type : "ammo_bolt",
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "physical",
		armor_penetration : 0.25,
		guidance : "dumb",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.15, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "150.common",	
		
		name : "Bolt Rounds, Standard",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_small, 0], //sprite and subimage of casing
		casing_sound : [snd_shellfall_small1, 0.9], //impact sound and pitch	
		inventory_subimage : [sp_xhair, 6]
	};
	#endregion
	
	#region stubber, auto and shotgun ammo
	Ammo_Shotgun_Buckshot = {//---------------------------- Buckshot rounds
		
		item_type : "ammo_shotgun",
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "physical",
		armor_penetration : 0,
		guidance : "scatter12",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.05, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "150.common",	
		
		name : "Shotgun Shells, Groxshot",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_shotgun, 0], //sprite and subimage of casing
		casing_sound : [snd_shotgun_shell_fall1, 1], //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	#endregion
	
	#region flamer, melta and plasma fuels
	Ammo_Flamer_Standard = {//---------------------------- flamer fuel
		
		item_type : "ammo_flamer",
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "thermal",
		armor_penetration : 0,
		guidance : "flame",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.01, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "150.common",	
		
		name : "Flamer Fuel, Standard",
		projectile_type : [sp_flamer_flames, 0], //sprite and subimage, if relevant
		projectile_color : [c_white, c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	
	Ammo_Melta_Standard = {//---------------------------- flamer fuel
		
		item_type : "ammo_melta",
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "thermal",
		armor_penetration : 3,
		guidance : "beam",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.01, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "150.common",	
		
		name : "Melta Fuel, Standard",
		projectile_type : [sp_beam, 0], //sprite and subimage, if relevant
		projectile_color : [c_orange, c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	
	Ammo_Plasma_Standard = {//---------------------------- Buckshot rounds
		
		item_type : "ammo_plasma",
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "thermal",
		armor_penetration : 0.8,
		guidance : "none",
		fuse : 0.99, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.01, //weight in lbs
		wear : 4, //durability cost on weapon when fired
		rarity : "150.common",	

		name : "Plasma Fuel, Standard",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_color_rgb(0,198,229), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	#endregion
}