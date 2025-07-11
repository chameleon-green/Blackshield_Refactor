
#region fire gun function
function FireGun (){
	
	var Overclock = (selector = "Overcharge");
	var Burst = string_count("Burst",selector);
	
	cycle = 0;
	alarm[0] = wpn_active.ROF / (1+Overclock+(Burst/2)); //timer to cycle weapon
	alarm[1] = 2; //timer to reset flash

	var Max_Spread = wpn_active.spread*10;
	var Spread_Divisor = irandom_range(1,5) * choose(-1,1)
	if(spread_angle < Max_Spread) {spread_angle += wpn_active.spread};
	instant_spread = (spread_angle/Spread_Divisor);
	
	var IsCharge = (selector = "Charge");
	var ChargeCap = wpn_active.heat_capacity*10;
	var ChargeMult = clamp( IsCharge*(burst_count/ChargeCap)*(ChargeCap/100), 1, 10 );

	magazine_active -= 1;
	burst_count += 1;

	if(string_count("scatter",ammo_active.guidance)){
		var Count = real(string_digits(ammo_active.guidance));
		var Cone = wpn_active.spread*5;
		repeat(Count) {
			instance_create_depth(flash_x+hspd,flash_y+vspd_readonly,depth+1,o_bullet,{
				origin_x : other.flash_x,
				origin_y : other.flash_y,
				type : other.ammo_active, 
				IFF : other.IFF,
				damage : (other.wpn_active.damage*other.ammo_active.damage_mod)/Count,
				damage_type : other.ammo_active.damage_type[0],
				direction : other.AimAngleBullet + other.instant_spread + random_range(-Cone,Cone),
				image_angle : direction,
				speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod,
				image_xscale : 0.75,
				image_yscale : 0.25,
				vspd : 0,//other.vspd_readonly,
				hspd : 0//other.hspd,
			});
		};
	}
	
	else {
		instance_create_depth(flash_x+hspd,flash_y+vspd_readonly,depth+1,o_bullet,{
			origin_x : other.flash_x,
			origin_y : other.flash_y,
			type : other.ammo_active, 
			IFF : other.IFF,
			damage : (other.wpn_active.damage*other.ammo_active.damage_mod)*ChargeMult,
			damage_type : other.ammo_active.damage_type[0],
			direction : other.AimAngleBullet + other.instant_spread,
			image_angle : direction,
			speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod,
			//image_xscale : ChargeMult,
			image_yscale : ChargeMult,
			vspd : 0,//other.vspd_readonly,
			hspd : 0//other.hspd,
		});
	};
	
	//------------------------------------------------------ make smoke ---------------------------------------------------
	
	if(wpn_active.gun_smoke != "none"){
		with(instance_create_depth(flash_x+hspd,flash_y+vspd_readonly,0,oprt_smoke)) {
			image_blend = other.wpn_active.gun_smoke[0]
			direction = other.AimAngleBullet + other.instant_spread
			depth = other.depth+1
			mass = other.wpn_active.gun_smoke[1]
			max_scale = other.wpn_active.gun_smoke[2]
			var speedArray = other.wpn_active.gun_smoke[3]
			speed = other.hspd + random_range(speedArray[0],speedArray[1])
			};
	};
	
	//------------------------------------------------------ make casing ----------------------------------------------------
	
	
	if(ammo_active.casing_type != "none" ) {
		var ejection_map = ds_map_create();
		skeleton_bone_state_get("gun_anim", ejection_map);
		var EjectX = ds_map_find_value(ejection_map, "worldX");
		var EjectY = ds_map_find_value(ejection_map, "worldY");
		//var EjectAng = ds_map_find_value(ejection_map, "worldAngleX");

		instance_create_depth(EjectX,EjectY,depth-1,o_gib,{
			sprite_index : other.ammo_active.casing_type[0],
			image_index : other.ammo_active.casing_type[1],
			hspd : -irandom_range(8,12)*other.image_xscale,
			vspd : -random_range(3,5),
			angspeed : irandom_range(-25,25),
			impact_sound : other.ammo_active.casing_sound[0],
			impact_sound_pitch : other.ammo_active.casing_sound[1]
		});

		ds_map_destroy(ejection_map);
	}; // eject event end
	
	if(wpn_active.heat_generation > 0) {
			if(IsCharge) {wpn_active_heat += wpn_active.heat_generation*ChargeMult*ChargeMult}
			else {wpn_active_heat += wpn_active.heat_generation}
	};
	
	instance_create_depth(flash_x,flash_y,depth+1,oprt_light);

	//--------------------------------------------------------- visual stuff --------------------------------------
	
	if(is_array(wpn_active.animation_group.fire)) {skeleton_anim_set_step(wpn_active.animation_group.fire[1],3)} //set fire anim for spooling guns
	else{skeleton_animation_set_ext(wpn_active.animation_group.fire,3)}; //set fire anim for non spooling guns

	if(wpn_active.flash_type != "none") {
		var flash = irandom(3);
		if(ammo_active.flash_color != "none") {skeleton_slot_color_set("slot_flash",ammo_active.flash_color[0],1)}
		else {skeleton_slot_color_set("slot_flash",wpn_active.flash_color[0],1)};
		skeleton_attachment_set("slot_flash",wpn_active.flash_type[flash]);
		skeleton_attachment_set("slot_flash_core",wpn_active.flash_type[flash] + " core");
	};

	if( variable_struct_exists(wpn_active.sound_group, "fire_loop") ) {
		var SNDGRP = wpn_active.sound_group;
		var FIRELOOP = SNDGRP.fire_loop;
		
			if(is_array(FIRELOOP)) {
				if(aud_fireloop = 0) {aud_fireloop = audio_play_sound(FIRELOOP[0],1,1)};
				if(aud_fireloop1 = 0) {aud_fireloop1 = audio_play_sound(FIRELOOP[1],1,1)};
			}
			
			else{
				if(aud_fireloop = 0) {aud_fireloop = audio_play_sound(wpn_active.sound_group.fire_loop,1,1)};
			};
	}
	else{		
		var ArraySize = array_length(wpn_active.sound_group.fire);
		var i = irandom_range(0,ArraySize-1);
		var FireSound = audio_play_sound(wpn_active.sound_group.fire[i],1,0);
		audio_sound_pitch(FireSound, random_range(0.85,1.05));	
	};
	
	audio_stop_sound(aud_chargeloop); aud_chargeloop = 0
};	
#endregion

#region Player Weapon Control Function
function PlayerWeaponControl(){	
	
var IsRanged = string_count("ranged",wpn_active.item_type);
var Swap_Key = keyboard_check_pressed(ord("Q"));

if(IsRanged) {	
	
	var _OverHeat = ((wpn_active_heat > wpn_active.heat_capacity) and (selector != "Supercharge") and (selector != "Overcharge"));
	var _CanFire = (CanShoot and magazine_active > 0 and cycle and !_OverHeat);
	var _CanReload = (CanReload and !reloading and is_string(ammo_active_id));
	
	var Semi_Fire = mouse_check_button_pressed(mb_left) and (selector = "Semi" or selector = "Supercharge" or selector = "Pump");
	var Auto_Fire = mouse_check_button(mb_left) and (selector = "Auto" or selector = "Overcharge");
	var Burst_Fire = mouse_check_button(mb_left) and (string_count("Burst",selector));
	var Charge_Fire = mouse_check_button(mb_left) and (selector = "Charge") and (charge_toggle); 
	var Reload_Key = keyboard_check_pressed(ord("R"));
	var Selector_Key = keyboard_check_pressed(ord("X"));
		
	var ChargeCap = wpn_active.heat_capacity*10;
	
	if(!CanShoot) {
		audio_stop_sound(aud_fireloop); aud_fireloop = 0;
		audio_stop_sound(aud_fireloop1); aud_fireloop1 = 0;
		audio_stop_sound(aud_chargeloop); aud_chargeloop = 0;
		audio_stop_sound(aud_spoolup); aud_spoolup = 0;
		if(is_array(wpn_active.animation_group.fire)) {skeleton_animation_clear(3)}
		burst_count = 0;
		spooled = 0;
		spindown_toggle = 0;
	};
	
	//reset burst count, spooling, shooting/spinning spool sound
	if(mouse_check_button_released(mb_left)) {
		
		if(is_array(wpn_active.animation_group.fire) && spindown_toggle) {
			audio_stop_sound(aud_spooldown); aud_spooldown = 0;
			skeleton_animation_clear(3);
			skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
		};
		
		var Minimum_Charge = (burst_count >= (wpn_active.heat_capacity*2.5));
		if(selector = "Charge" and charge_toggle and _CanFire and Minimum_Charge) {FireGun()};
		
		charge_toggle = 1;
		burst_count = 0;
		spooled = 0;
		
		if(string_count("Burst",selector)) {
			var _Cycle = function() {cycle = 1};
			alarm[0] = 1; cycle = 0;
			var ROF3 = round(wpn_active.ROF*4); 
			if((time_source_get_state(burst_timer) = time_source_state_stopped) or (time_source_get_state(burst_timer) = time_source_state_initial)) {
				time_source_reconfigure(burst_timer,ROF3,time_source_units_frames,_Cycle);
				time_source_start(burst_timer);
			};
		};
		
		audio_stop_sound(aud_fireloop); aud_fireloop = 0;
		audio_stop_sound(aud_fireloop1); aud_fireloop1 = 0;
		audio_stop_sound(aud_chargeloop); aud_chargeloop = 0
		audio_stop_sound(aud_spoolup); aud_spoolup = 0;
	};
	
	//check for empty mags, reload interrupt for single loaders, and spool up spoolguns
	if(mouse_check_button_pressed(mb_left)) {	
		
		if(magazine_active = 0 and !reloading and CanShoot) {
			audio_play_sound_at(wpn_active.sound_group.empty,x,y,0,100,100,1,0,1);
		};
		
		if(reloading = 1 and is_array(wpn_active.animation_group.reload)) {
			skeleton_animation_clear(4);
			skeleton_anim_set_step(wpn_active.animation_group.reload[2],4);	
		};		
		
		audio_stop_sound(aud_spooldown); aud_spooldown = 0;
	};
	
	//spindown when we hit 0 rounds for spoolguns
	if(magazine_active = 0 && is_array(wpn_active.animation_group.fire) && spindown_toggle) {
			skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
			audio_stop_sound(aud_fireloop); aud_fireloop = 0;
			audio_stop_sound(aud_fireloop1); aud_fireloop1 = 0;
	};
	
//--------------------------------------- SHOOT BULLETS IN VARIOUS MODES ------------------------------

	if(Semi_Fire and _CanFire) {
		time_source_reset(burst_timer);
		FireGun();
	};	
	
	if(Auto_Fire and _CanFire) {
		time_source_reset(burst_timer);
		if(is_array(wpn_active.animation_group.fire) and !spooled) {
			skeleton_anim_set_step(wpn_active.animation_group.fire[0],3)
		}
		else{FireGun()};
	};
	
	if(Burst_Fire && _CanFire and (burst_count < string_digits(selector))) {
		FireGun();
	};

//---------------------------------------- Charge type weapon code -----------------------------------
	if(Charge_Fire and _CanFire and charge_toggle) {
		time_source_reset(burst_timer);
		burst_count += 1;
		
		var Direction = random(360);
		var Divisor = clamp(round(300/burst_count),2,12);
		
		if(frac(burst_count/Divisor)) = 0 { 
			instance_create_depth(flash_x+hspd,flash_y+vspd,depth-1,o_chargeparticle,{	
				image_angle : Direction,
				creator : id,
				image_yscale : random_range(0.7,1.2)
			});
		};
		
		var FlashScale = clamp(burst_count/ChargeCap,0.05,1)*1.5;
		if(frac(burst_count/2)) = 0 {var FlashScale = FlashScale*0.6};
		
		var FlashColor = wpn_active.flash_color[0]; var FlashColorCore = wpn_active.flash_color[1];
		if(ammo_active.flash_color != "none") {var FlashColor = ammo_active.flash_color[0]; var FlashColorCore = ammo_active.flash_color[1]};
		
		draw_sprite_ext(sp_charge_flash,1,flash_x+hspd*2,flash_y+vspd*2,FlashScale+0.5,FlashScale+0.5,random(360),FlashColor,1);
		draw_sprite_ext(sp_charge_flash,0,flash_x+hspd*2,flash_y+vspd*2,FlashScale+0.5,FlashScale+0.5,random(360),FlashColorCore,1);
		
		var Pitch = 2*(burst_count/ChargeCap);
		var _Pitch = clamp(Pitch,0.25,2);
		
		if(aud_chargeloop = 0) {aud_chargeloop = audio_play_sound(snd_plasma_charge_loop,1,1)};
		audio_sound_pitch(aud_chargeloop,_Pitch);
		audio_sound_gain(aud_chargeloop,Pitch,0.1);
		
		if(burst_count >= ChargeCap) {
			FireGun();
			charge_toggle = 0;
			burst_count = 0
		};
	};
		
//--------------------------------------------- RELOAD AND SELECTOR SWITCH ---------------------------------	
	
	if(Reload_Key && _CanReload) {	
		
		if(!string_count("Shotgun",string(wpn_active))) {magazine_active = 0};
		burst_count = 0;
		reloading = 1;
		skeleton_animation_clear(3); skeleton_animation_clear(3);
		skeleton_animation_clear(4); skeleton_animation_clear(5);		
		skeleton_animation_clear(6); skeleton_animation_clear(8);
		
		if(is_array(wpn_active.animation_group.reload)) {skeleton_animation_set_ext(wpn_active.animation_group.reload[0],4)}
		else{skeleton_animation_set_ext(wpn_active.animation_group.reload,4)};
	};
	
	if(Selector_Key and array_length(wpn_active.firemodes) > 1) {
		burst_count = 0;
		
		audio_play_sound(wpn_active.sound_group.selector,1,0)
		if(selector_real < array_length(wpn_active.firemodes)-1) {selector_real += 1;} else{selector_real = 0};
		
		selector = wpn_active.firemodes[selector_real];
	};

}; //---------- ISRANGED CHECK


//++++++++++++++++++++++++++++++++++++++++++++++ QUICKSWAP ++++++++++++++++++++++++++++++++++++++++++++	
//++++++++++++++++++++++++++++++++++++++++++++++ QUICKSWAP ++++++++++++++++++++++++++++++++++++++++++++	
	
	if(Swap_Key && !rolling && !swinging && !reloading && !mouse_check_button(mb_left) && (skeleton_animation_get_ext(3) = "") ) {	
		
		switch_toggle = 1;
		
		audio_stop_sound(aud_fireloop); aud_fireloop = 0;
		audio_stop_sound(aud_fireloop1); aud_fireloop1 = 0;
		audio_stop_sound(aud_chargeloop); aud_chargeloop = 0
		audio_stop_sound(aud_spoolup); aud_spoolup = 0;
		burst_count = 0; spooled = 0; skeleton_animation_clear(3); skeleton_animation_clear(5);
		
		var ActivePrimary = ( (wpn_active.weapon_slot[0] = "primary") or (wpn_active_id = -2) ); //we have a primary equipped
		var ActiveSecondary = ( (wpn_active.weapon_slot[0] = "secondary") or (wpn_active.weapon_slot[0] = "melee") or (wpn_active_id = -3) ); //we have a secondary equipped
		
		var SwapWeapon = function(_Slot,_Slot2,Item) {//_Slot is the slot to swap to, _Slot2 is the currently active slot
			skeleton_animation_clear(1); skeleton_animation_clear(3);
			variable_instance_set(id,"magazine_" + _Slot2, magazine_active);
						
			var Ranged = (string_count("ranged",Item.item_type));			
			wpn_active = variable_instance_get(id,"wpn_" + _Slot); 
			wpn_active_id = variable_instance_get(id,"wpn_" + _Slot + "_id");
						
			if(Ranged) {				
				magazine_active = variable_instance_get(id,"magazine_" + _Slot);
				ammo_active = variable_instance_get(id,"ammo_" + _Slot);
				ammo_active_id = variable_instance_get(id,"ammo_" + _Slot + "_id");
				selector_real = 0;
				selector = wpn_active.firemodes[selector_real];
				skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment);
				skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);
				
				if( (Item.weapon_slot[0] = "secondary") && (wpn_active_melee != Unarmed_Fists) ) {
					var Hands = wpn_active_melee.weapon_slot[1];
					if(Hands = 3) {
						skeleton_animation_clear(1); skeleton_animation_clear(3);
						skeleton_anim_set_step(wpn_active_melee.animation_group.idle,5);
						skeleton_attachment_set("slot_melee_weapon",wpn_active_melee.weapon_attachment); 
					};
				};
			}	
			
			else{ //2 handed melee weapons
				var Hands = Item.weapon_slot[1];
				if(Hands = 2) {
					skeleton_animation_clear(1); skeleton_animation_clear(3);
					skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment); 
					skeleton_attachment_set("slot_gun magazine",-1)
				};				
			};
			
			skeleton_anim_set_step(wpn_active.animation_group.idle,1);	
		};
		
		if(ActivePrimary) {SwapWeapon("secondary","primary",wpn_secondary)};
		if(ActiveSecondary) {SwapWeapon("primary","secondary",wpn_primary)};
		
	};
		
};
#endregion