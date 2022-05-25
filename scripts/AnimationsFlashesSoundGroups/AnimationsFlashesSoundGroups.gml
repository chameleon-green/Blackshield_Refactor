// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AnimationsFlashesSoundGroups(){
	
//+++++++++++++++++++++++++++++++++++++++++++ ANIMATION GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++++
	
	anmgrp_boltgun_phobos = {
		idle : "idle_bolter_phobos",
		fire : "firing_bolter_phobos",
		reload :  "reload_rifle_phobos"	
	};


//+++++++++++++++++++++++++++++++++++++++++++ MUZZLE FLASH GROUPS +++++++++++++++++++++++++++++++++++++++++
	
	flash_med_normal[3] = "flash med 4";
	flash_med_normal[2] = "flash med 3";
	flash_med_normal[1] = "flash med 2";
	flash_med_normal[0] = "flash med 1";
	
//+++++++++++++++++++++++++++++++++++++++++++ SOUND GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++

	sndgrp_boltgun1 = {
		fire : 1,//snd_boltgun1,
		mag_in : 1,//snd_magin,
		mag_out : 1,//snd_magout,
		rack_slide : 1//snd_rackslide
	};
}