// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AnimationsFlashesSoundGroups(){
	
//+++++++++++++++++++++++++++++++++++++++++++ ANIMATION GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++++
	
	anmgrp_boltgun_phobos = {
		idle : "Bolt Weapons/idle_bolter_phobos",
		fire : "Bolt Weapons/firing_bolter_phobos",
		reload : "Bolt Weapons/reload_rifle_phobos"	
	};


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
}