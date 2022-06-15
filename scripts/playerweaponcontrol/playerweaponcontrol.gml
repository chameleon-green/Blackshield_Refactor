
#region fire gun function
function FireGun (){
	cycle = 0;
	alarm[0] = wpn_active.ROF; //timer to cycle weapon
	alarm[1] = 2; //timer to reset flash

	var Max_Spread = wpn_active.spread*10;
	var Spread_Divisor = irandom_range(1,5) * choose(-1,1)
	if(spread_angle < Max_Spread) {spread_angle += wpn_active.spread};
	instant_spread = (spread_angle/Spread_Divisor);

	magazine_active -= 1;
	burst_count += 1;

	if(string_count("scatter",ammo_active.guidance)){
		var Count = string_digits(ammo_active.guidance);
		var Cone = wpn_active.spread*5
		repeat(Count) {
			instance_create_depth(flash_x,flash_y,depth+1,o_bullet,{
				type : other.ammo_active, 
				IFF : other.IFF,
				damage : other.wpn_active.damage/Count,
				direction : other.AimAngleBullet + other.instant_spread + random_range(-Cone,Cone),
				speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod,
				image_xscale : 0.75,
				image_yscale : 0.25
			});
		};
	};
	
	else {
		
		var IsCharge = (selector = "Charge");
		var ChargeMult = IsCharge*(burst_count/400)+1;
		
		instance_create_depth(flash_x,flash_y,depth+1,o_bullet,{
			type : other.ammo_active, 
			IFF : other.IFF,
			damage : other.wpn_active.damage*ChargeMult,
			direction : other.AimAngleBullet + other.instant_spread,
			speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod,
			//image_xscale : ChargeMult,
			image_yscale : ChargeMult * ChargeMult
		});
	};


	//--------------------------------------------------------- visual stuff --------------------------------------
	
	if(is_array(wpn_active.animation_group.fire)) {skeleton_animation_set_ext(wpn_active.animation_group.fire[1],3)}; //set fire anim for spooling guns
	else{skeleton_animation_set_ext(wpn_active.animation_group.fire,3)}; //set fire anim for non spooling guns

	if(wpn_active.flash_type != "none") {
		var flash = irandom(3);
		if(ammo_active.flash_color != "none") {skeleton_slot_color_set("slot_flash",ammo_active.flash_color[0],1)};
		else {skeleton_slot_color_set("slot_flash",wpn_active.flash_color[0],1)};
		skeleton_attachment_set("slot_flash",wpn_active.flash_type[flash]);
		skeleton_attachment_set("slot_flash_core",wpn_active.flash_type[flash] + " core");
	};

	if( variable_struct_exists(wpn_active.sound_group, "fire_loop") ) {
		if(aud_fireloop = 0) {aud_fireloop = audio_play_sound_at(wpn_active.sound_group.fire_loop,x,y,0,100,100,1,1000,10)};
	};
	else{
		var FireSound = audio_play_sound_at(wpn_active.sound_group.fire,x,y,0,100,100,1,0,1);
		audio_sound_pitch(FireSound, random_range(0.9,1.1));	
	};
	
	audio_stop_sound(aud_chargeloop); aud_chargeloop = 0
};	
#endregion

#region Player Weapon Control Function
function PlayerWeaponControl(){	
	
	var _CanFire = (CanShoot and magazine_active > 0 and cycle);
	var _CanReload = (CanReload and !reloading);
	
	var Semi_Fire = mouse_check_button_pressed(mb_left) and (selector = "Semi" or selector = "Supercharge" or selector = "Pump");
	var Auto_Fire = mouse_check_button(mb_left) and (selector = "Auto" or selector = "Overcharge");
	var Burst_Fire = mouse_check_button(mb_left) and (string_count("Burst",selector));
	var Charge_Fire = mouse_check_button(mb_left) and (selector = "Charge") and (charge_toggle); 
	var Reload_Key = keyboard_check_pressed(ord("R"));
	var Selector_Key = keyboard_check_pressed(ord("X"));
	
	//reset burst count, spooling, shooting/spinning spool sound
	if(mouse_check_button_released(mb_left)) {
		
		if(selector = "Charge" and charge_toggle and _CanFire) {FireGun()};
		
		charge_toggle = 1;
		burst_count = 0;
		spooled = 0;
		if(is_array(wpn_active.animation_group.fire) and spindown_toggle ) {
			skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
		};
		audio_stop_sound(aud_fireloop); aud_fireloop = 0;
		audio_stop_sound(aud_chargeloop); aud_chargeloop = 0
		
	};
	
	//check for empty mags, reload interrupt for single loaders, and spool up spoolguns
	if(mouse_check_button_pressed(mb_left)) {	
		
		if(magazine_active = 0) {
			audio_play_sound_at(wpn_active.sound_group.empty,x,y,0,100,100,1,0,1);
		};
		
		if(reloading = 1 and is_array(wpn_active.animation_group.reload)) {
			skeleton_animation_clear(4);
			skeleton_anim_set_step(wpn_active.animation_group.reload[2],4);	
		};		
	};
	
	//spindown when we hit 0 rounds for spoolguns
	if(magazine_active = 0 && is_array(wpn_active.animation_group.fire) && spindown_toggle) {
			skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
			audio_stop_sound(aud_fireloop); aud_fireloop = 0;
	};
	
//--------------------------------------- SHOOT BULLETS IN VARIOUS MODES ------------------------------

	if(Semi_Fire and _CanFire) {FireGun()};	
	if(Auto_Fire and _CanFire) {
		if(is_array(wpn_active.animation_group.fire) and !spooled) {
			skeleton_anim_set_step(wpn_active.animation_group.fire[0],3)
		};
		else{FireGun()};
	};
	if(Burst_Fire and _CanFire and (burst_count < string_digits(selector))) {FireGun()};

//---------------------------------------- Charge type weapon code -----------------------------------
	if(Charge_Fire and _CanFire and charge_toggle) {
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
		
		var FlashScale = clamp(burst_count/400,0.05,1)*1.5;
		if(frac(burst_count/2)) = 0 {var FlashScale = FlashScale*0.6};
		
		var FlashColor = wpn_active.flash_color[0]; var FlashColorCore = wpn_active.flash_color[1];
		if(ammo_active.flash_color != "none") {var FlashColor = ammo_active.flash_color[0]; var FlashColorCore = ammo_active.flash_color[1]};
		
		draw_sprite_ext(sp_charge_flash,1,flash_x+hspd*2,flash_y+vspd*2,FlashScale+0.5,FlashScale+0.5,random(360),FlashColor,1);
		draw_sprite_ext(sp_charge_flash,0,flash_x+hspd*2,flash_y+vspd*2,FlashScale+0.5,FlashScale+0.5,random(360),FlashColorCore,1);
		
		var Pitch = 2*(burst_count/400);
		var _Pitch = clamp(Pitch,0.25,2);
		
		if(aud_chargeloop = 0) {aud_chargeloop = audio_play_sound_at(snd_plasma_charge_loop,x,y,0,100,100,1,1,1)};
		audio_sound_pitch(aud_chargeloop,_Pitch);
		audio_sound_gain(aud_chargeloop,Pitch,0.1);
		
		if(burst_count >= 400) {
			FireGun();
			charge_toggle = 0;
			burst_count = 0
		};
	};
		
//--------------------------------------------- RELOAD AND SELECTOR SWITCH ---------------------------------	
	
	if(Reload_Key and _CanReload) {	
		burst_count = 0;
		reloading = 1;
		skeleton_animation_clear(3); skeleton_animation_clear(3);
		skeleton_animation_clear(4); skeleton_animation_clear(6);		
		skeleton_animation_clear(8);
		
		if(is_array(wpn_active.animation_group.reload)) {skeleton_animation_set_ext(wpn_active.animation_group.reload[0],4)};
		else{skeleton_animation_set_ext(wpn_active.animation_group.reload,4)};
	};
	
	if(Selector_Key and array_length(wpn_active.firemodes) > 1) {
		burst_count = 0;
		
		audio_play_sound(wpn_active.sound_group.selector,1,0)
		if(selector_real < array_length(wpn_active.firemodes)-1) {selector_real += 1;} else{selector_real = 0};
		
		selector = wpn_active.firemodes[selector_real];
	};
	
};
#endregion