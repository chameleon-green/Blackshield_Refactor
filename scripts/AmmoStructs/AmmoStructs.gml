
#region Ammo cost calculator
function AmmoCost(Item) {
	var TechLvl = string_digits(Item.rarity);
	var Size = Item.weight;
	var DmgMod = Item.damage_mod;
	var Penetration = Item.armor_penetration;
	
	var Cost = power(sqr(TechLvl),0.58) + (power(Size,2.5)*10000*(DmgMod*2)) + clamp(Penetration*800,0,1000)
	return Cost/400;
};
#endregion

function AmmoStructs() {
	#region small bolt rounds
	Ammo_Bolt_Standard = { //---------------------------- STANDARD BOLT ROUNDS
		
		item_type : "ammo_bolt",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : 0.10,
		guidance : "dumb",
		fuse : 0.25, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive. 
		special : "none", //an array of any special effects
		impact_type : ["explosion", 3, 4, 1, c_gray, 0, 0, snd_explode_small1], //type, boom size, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.15, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "800.common",	
		
		name : "Bolt Rounds, Standard",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_small, 0], //sprite and subimage of casing
		casing_sound : [snd_shellfall_small1, 0.9], //impact sound and pitch	
		inventory_subimage : [sp_bolt_ammo, 0]
	};
	
	Ammo_Bolt_Kraken = { //---------------------------- KRAKEN BOLT ROUNDS
		
		item_type : "ammo_bolt",
		damage_mod : 1.1,
		ROF_mod : 0.8,
		range_mod : 1.25,
		velocity_mod : 1.25,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : 0.25,
		guidance : "dumb",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : "none", //an array of any special effects
		impact_type : ["dust",4,1,c_gray], //type, smoke mass, smoke max scale, smoke count
		
		weight : 0.18, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "1000.common",	
		
		name : "Bolt Rounds, Kraken",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [c_red, c_white],
		flash_color : [c_red, c_white], //color override for flash, if relevant
		casing_type : [sp_casing_small, 1], //sprite and subimage of casing
		casing_sound : [snd_shellfall_small1, 0.9], //impact sound and pitch	
		inventory_subimage : [sp_bolt_ammo, 1]
	};
	#endregion
	
	#region stubber, auto and shotgun ammo
	Ammo_Shotgun_Buckshot = {//---------------------------- Buckshot rounds
		
		item_type : "ammo_shotgun",
		damage_mod : 1.5,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : -0.05,
		guidance : "scatter6",
		fuse : 0.05, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : "none", //an array of any special effects
		impact_type : ["dust",8,1,c_gray], //type, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.04, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "050.common",	
		
		name : "Shotgun Shells, Groxshot",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_shotgun, 0], //sprite and subimage of casing
		casing_sound : [snd_shotgun_shell_fall1, 1], //impact sound and pitch
		inventory_subimage : [sp_shotgun_ammo, 0]
	};
	
	Ammo_Shotgun_Slug = {//---------------------------- Buckshot rounds
		
		item_type : "ammo_shotgun",
		damage_mod : 1.50,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : -0.1,
		guidance : "none",
		fuse : 0.15, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : "none", //an array of any special effects
		impact_type : ["dust",8,1,c_gray], //type, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.04, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "050.common",	
		
		name : "Shotgun Shells, Slug",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_shotgun, 1], //sprite and subimage of casing
		casing_sound : [snd_shotgun_shell_fall1, 1], //impact sound and pitch
		inventory_subimage : [sp_shotgun_ammo, 1]
	};
	
	Ammo_Auto_Ball = {//---------------------------- Ball rounds
		
		item_type : "ammo_autogun",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : 0,
		guidance : "none",
		fuse : 0.2, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : "none", //an array of any special effects
		impact_type : ["dust",8,1,c_gray], //type, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.01, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "065.common",	
		
		name : "Autogun Rounds, Ball",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_shotgun, 1], //sprite and subimage of casing
		casing_sound : [snd_shotgun_shell_fall1, 1], //impact sound and pitch
		inventory_subimage : [sp_shotgun_ammo, 1]
	};
	
	Ammo_Autocannon_Ball = {//---------------------------- Ball rounds
		
		item_type : "ammo_autocannon",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["physical","PHYS"],
		armor_penetration : 0.2,
		guidance : "none",
		fuse : 0.5, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : "none", //an array of any special effects
		impact_type : ["dust",8,1,c_gray], //type, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.41,//0.01, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "300.common",	
		
		name : "Autocannon Rounds, Ball",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_colour_rgb(255, 230, 90), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : [sp_casing_shotgun, 1], //sprite and subimage of casing
		casing_sound : [snd_shotgun_shell_fall1, 1], //impact sound and pitch
		inventory_subimage : [sp_shotgun_ammo, 1]
	};
	#endregion
	
	#region flamer, melta and plasma fuels
	Ammo_Flamer_Standard = {//---------------------------- flamer fuel
		
		item_type : "ammo_flamer",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["thermal","THER"],
		armor_penetration : 0,
		guidance : "flame",
		fuse : 3, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : ["ignite"], //an array of any special effects
		impact_type : ["firey",8,1,c_gray], //type, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound
		
		weight : 0.02, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "080.common",	
		
		name : "Flamer Fuel, Standard",
		projectile_type : [sp_flamer_flames, 0], //sprite and subimage, if relevant
		projectile_color : [c_white, c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	
	Ammo_Flamer_Balefire = {//---------------------------- radioactive flamer fuel
		
		item_type : "ammo_flamer",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["radiation","RADI"],
		armor_penetration : 0,
		guidance : "flame",
		fuse : 3, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : ["ignite","irradiate"], //an array of any special effects
		impact_type : ["firey",8,1,c_gray],
		
		weight : 0.02, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "080.common",	
		
		name : "Flamer Fuel, Balefire",
		projectile_type : [sp_flamer_flames_bw, 0], //sprite and subimage, if relevant
		projectile_color : [c_lime, c_lime],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	
	
	Ammo_Melta_Standard = {//---------------------------- melta fuel
		
		item_type : "ammo_melta",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["thermal","THER"],
		armor_penetration : 3,
		guidance : "beam",
		fuse : 0.3, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : ["ignite"], //an array of any special effects
		impact_type : ["firey",8,1,c_gray],
		
		weight : 0.01, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "600.common",	
		
		name : "Melta Fuel, Standard",
		projectile_type : [sp_beam, 0, 2], //sprite, subimage and scaling, if relevant
		projectile_color : [c_orange, c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	
	Ammo_Plasma_Standard = {//---------------------------- plasma fuel
		
		item_type : "ammo_plasma",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["thermal","THER"],
		armor_penetration : 0.8,
		guidance : "none",
		fuse : 0.01, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : ["ignite"], //an array of any special effects
		impact_type : ["dust",8,1,c_gray],
		
		weight : 0.1, //weight in lbs
		wear : 4, //durability cost on weapon when fired
		rarity : "800.common",	

		name : "Plasma Fuel, Standard",
		projectile_type : [sp_bullet, 0], //sprite and subimage, if relevant
		projectile_color : [make_color_rgb(0,198,229), c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	#endregion
	
	#region laser power packs 
	Ammo_Laser_Pack_Standard = {//---------------------------- lasgun power packs
		
		item_type : "ammo_laser_small",
		damage_mod : 1.00,
		ROF_mod : 1.00,
		range_mod : 1.00,
		velocity_mod : 1.00,
		
		damage_type : ["thermal","THER"],
		armor_penetration : 0,
		guidance : "beam",
		fuse : 0.25, //how much resistance the projectile must encounter to detonate, as a factor of its dmg. smaller no. = more sensitive
		special : ["ignite"], //an array of any special effects
		impact_type : ["dust",8,1,c_gray],
		
		weight : 0.02, //weight in lbs
		wear : 1, //durability cost on weapon when fired
		rarity : "080.common",	
		
		name : "Lasgun Charge Pack, Standard",
		projectile_type : [sp_beam, 1, 1], //sprite, subimage and scaling, if relevant
		projectile_color : [c_red, c_white],
		flash_color : "none", //color override for flash, if relevant
		casing_type : "none", //sprite and subimage of casing
		casing_sound : "none", //impact sound and pitch
		inventory_subimage : [sp_xhair, 6]
	};
	#endregion
}