// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AnimationsFlashesSoundGroups(){
	
//+++++++++++++++++++++++++++++++++++++++++++ ANIMATION GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++++
	
	anmgrp_boltgun_phobos = {
		idle : "Bolt Weapons/idle_bolter_phobos",
		fire : "Bolt Weapons/firing_bolter_phobos",
		reload : "Bolt Weapons/reload_rifle_phobos"	
	};
	
	anmgrp_shotgun_astartes = {
		idle : "Ballistic Weapons/idle_shotgun_astartes",
		fire : "Ballistic Weapons/firing_shotgun_astartes",
		reload : ["Ballistic Weapons/reload_shotgun_astartes1","Ballistic Weapons/reload_shotgun_astartes2","Ballistic Weapons/reload_shotgun_astartes3"]
	};
	
	anmgrp_flamer_astartes = {
		idle : "Flame Weapons/idle_flamer_astartes",
		fire : ["Flame Weapons/spinup_flamer_astartes","Flame Weapons/firing_flamer_astartes","Flame Weapons/spindown_flamer_astartes"],
		reload : "Flame Weapons/reload_flamer_astartes"
	}


//+++++++++++++++++++++++++++++++++++++++++++ MUZZLE FLASH GROUPS +++++++++++++++++++++++++++++++++++++++++
	
	flash_med_normal[3] = "flash med 4";
	flash_med_normal[2] = "flash med 3";
	flash_med_normal[1] = "flash med 2";
	flash_med_normal[0] = "flash med 1";
	
//+++++++++++++++++++++++++++++++++++++++++++ SOUND GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++

	sndgrp_boltgun1 = {
		fire : snd_bolter1,
		mag_in : snd_magin1,
		mag_out : snd_magout1,
		rack_slide : snd_rackslide1,
		empty : snd_click_empty,
		selector : snd_selector1
	};
	
	sndgrp_shotgun1 = {
		fire : snd_shotgun1,
		mag_in : snd_shotgun_reload_single1,
		mag_out : snd_shotgun_reload_single1,
		rack_slide : snd_shotgun_rackslide1,
		empty : snd_click_empty,
		selector : snd_selector1
	};
	
	sndgrp_flamer1 = {
		fire : snd_shotgun1,
		mag_in : snd_shotgun_reload_single1,
		mag_out : snd_shotgun_reload_single1,
		rack_slide : snd_shotgun_rackslide1,
		empty : snd_click_empty,
		selector : snd_selector1
	};
}