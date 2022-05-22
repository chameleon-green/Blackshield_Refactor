// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AnimationsFlashesSoundGroups(){
	
//+++++++++++++++++++++++++++++++++++++++++++ ANIMATION GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++++
	
	anmgrp_boltgun_phobos = {
		idle : "idle_bolter_phobos",
		fire : "fire_bolter_phobos",
		reload :  "fire_bolter_phobos"	
	};


//+++++++++++++++++++++++++++++++++++++++++++ MUZZLE FLASH GROUPS +++++++++++++++++++++++++++++++++++++++++
	
	flash_med_normal[4] = 0;
	flash_med_normal[3] = 0;
	flash_med_normal[2] = 0;
	flash_med_normal[1] = 0;
	flash_med_normal[0] = 0;
	
//+++++++++++++++++++++++++++++++++++++++++++ SOUND GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++

	sndgrp_boltgun1 = {
		fire : snd_boltgun1,
		mag_in : snd_magin,
		mag_out : snd_magout,
		rack_slide : snd_rackslide
	};
	
//+++++++++++++++++++++++++++++++++++++++++++ FIREMODE GROUPS ++++++++++++++++++++++++++++++++++++++++++++
	
	firemode_rifle[1] = "auto";
	firemode_rifle[0] = "semi";

}