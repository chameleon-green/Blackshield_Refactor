// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AnimationsFlashesSoundGroups(){
	
//+++++++++++++++++++++++++++++++++++++++++++ ANIMATION GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++++
	
	anmgrp_boltgun_phobos = {
		idle : "Bolt Weapons/idle_bolter_phobos",
		fire : "Bolt Weapons/firing_bolter_phobos",
		reload : "Bolt Weapons/reload_rifle_phobos",
	};
	
	anmgrp_boltpistol_tigrus = {
		idle : "Bolt Weapons/idle_pistol_tigrus",
		fire : "Bolt Weapons/firing_pistol_tigrus",
		reload : "Bolt Weapons/reload_pistol_tigrus",
		sprint : "Basic Movement/sprint_full_melee"
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
	};
	
	anmgrp_meltagun_proteus = {
		idle : "Melta Weapons/idle_meltagun_proteus",
		fire : ["Melta Weapons/spinup_meltagun_proteus","Melta Weapons/firing_meltagun_proteus","Melta Weapons/spindown_meltagun_proteus"],
		reload : "Melta Weapons/reload_meltagun_proteus"
	};
	
	anmgrp_plasmagun_thunderbolt = {
		idle : "Plasma Weapons/idle_plasmagun_thunderbolt",
		fire : "Plasma Weapons/firing_plasmagun_thunderbolt",
		reload : "Plasma Weapons/reload_plasmagun_thunderbolt"			
	};
	
	anmgrp_chainsword_thunderedge = {
		idle : "Chain Weapons/idle_sword_thunderedge",
		strike : "Chain Weapons/strike_anim_sword_thunderedge",
		light_attack : ["Chain Weapons/attack_sword_chain_light1","Chain Weapons/attack_sword_chain_light2","Chain Weapons/attack_sword_chain_light3"],
		windup : "Chain Weapons/attack_sword_chain_windup1",
		heavy_attack : "Chain Weapons/attack_sword_chain_heavy1"	
	};
	
	anmgrp_fists = {
		idle : "Basic Movement/idle_fists",
		strike : "",
		light_attack : ["attack_fists_light1","attack_fists_light2","attack_fists_light3"],
		windup : "Chain Weapons/attack_sword_chain_windup1",
		heavy_attack : "Chain Weapons/attack_sword_chain_heavy1",	
		sprint : "Basic Movement/sprint_full_melee",
		walk : "Basic Movement/walk_melee",
		backwalk : "Basic Movement/backwalk_melee"
	};
	
	anmgrp_polearm1 = {
		idle : "Power Weapons/idle_heavyhammer_proteus",
		strike : "",
		light_attack : ["Power Weapons/attack_heavyhammer_proteus_light1","Power Weapons/attack_heavyhammer_proteus_light2","Power Weapons/attack_heavyhammer_proteus_light3"],
		windup : "Power Weapons/attack_heavyhammer_proteus_windup1",
		heavy_attack : "Power Weapons/attack_heavyhammer_proteus_heavy1",	
		sprint : "Basic Movement/sprint_full_melee_heavy",
		walk : "Basic Movement/walk_melee_heavy",
		backwalk : "Basic Movement/backwalk_melee_heavy"
	};


//+++++++++++++++++++++++++++++++++++++++++++ MUZZLE FLASH GROUPS +++++++++++++++++++++++++++++++++++++++++
	
	flash_med_normal[3] = "flash med 4";
	flash_med_normal[2] = "flash med 3";
	flash_med_normal[1] = "flash med 2";
	flash_med_normal[0] = "flash med 1";
	
	flash_med_melta[3] = "flash melta 1";
	flash_med_melta[2] = "flash melta 1";
	flash_med_melta[1] = "flash melta 1";
	flash_med_melta[0] = "flash melta 1";
	
//+++++++++++++++++++++++++++++++++++++++++++ SOUND GROUPS ++++++++++++++++++++++++++++++++++++++++++++++++

	sndgrp_boltgun1 = {
		fire : snd_bolter1,
		mag_in : snd_magin1,
		mag_out : snd_magout1,
		rack_slide : snd_rackslide1,
		empty : snd_click_empty,
		selector : snd_selector1
	};
	
	sndgrp_boltgun2 = {
		fire : snd_bolterlight1,
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
		fire_loop : snd_flamer_loop1,
		mag_in : snd_flamer_magin,
		mag_out : snd_flamer_magout,
		rack_slide : snd_shotgun_rackslide1,
		empty : snd_flamer_empty,
		selector : snd_selector1,
		spinup : snd_flamer_windup,
		spindown : snd_flamer_winddown
	};
	
	sndgrp_melta1 = {
		fire_loop : snd_melta_loop1,
		mag_in : snd_flamer_magin,
		mag_out : snd_flamer_magout,
		empty : snd_flamer_empty,
		selector : snd_selector1,
		spinup : snd_melta_windup,
		spindown : snd_melta_winddown
	};
	
	sndgrp_plasma1 = {
		fire : snd_plasma_small1,
		mag_in : snd_plasma_magin,
		mag_out : snd_plasma_magout,
		empty : snd_click_empty,
		selector : snd_selector1
	};
	
	sndgrp_chain1 = {
		attack : [snd_chain1,snd_chain2,snd_chain3],
		idle : snd_chain_idle_loop1
	};
	
	sndgrp_unarmed1 = {
		attack : [snd_punch1,snd_punch2,snd_punch3],
		idle : snd_chain_idle_loop1
	};
	
	sndgrp_melee_heavy1 = {
		attack : [snd_swing_heavy1,snd_swing_heavy2,snd_swing_heavy3],
		idle : snd_chain_idle_loop1
	};
}