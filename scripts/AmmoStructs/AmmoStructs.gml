// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AmmoStructs() {
	Ammo_Bolt_Standard = //---------------------------- STANDARD BOLT ROUNDS
	{
		damage_mod : 1,
		ROF_mod : 1,
		range_mod : 1,
		velocity_mod :1,
		
		damage_type : "physical",
		armor_penetration : 0.1,
		guidance : "dumb",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg
		special : "none", //an array of any special effects
		
		weight : 0.15, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "150.common",	
		
		projectile_color : make_colour_rgb(255, 230, 90),
		projectile_color_core : c_white,
		flash_color : "none", //color override for flash, if relevant
		casing_type : 0
		
	};
}