
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
	
	else{
		instance_create_depth(flash_x,flash_y,depth+1,o_bullet,{
			type : other.ammo_active, 
			IFF : other.IFF,
			damage : other.wpn_active.damage,
			direction : other.AimAngleBullet + other.instant_spread,
			speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod
		});
	};


	//--------------------------------------------------------- visual stuff --------------------------------------
	skeleton_animation_set_ext(wpn_active.animation_group.fire,3);

	if(wpn_active.flash_type != "none") {
		var flash = irandom(3);
		if(ammo_active.flash_color != "none") {skeleton_slot_color_set("slot_flash",ammo_active.flash_color[0],1)};
		else {skeleton_slot_color_set("slot_flash",wpn_active.flash_color[0],1)};
		skeleton_attachment_set("slot_flash",wpn_active.flash_type[flash]);
		skeleton_attachment_set("slot_flash_core",wpn_active.flash_type[flash] + " core");
	};

	var FireSound = audio_play_sound_at(wpn_active.sound_group.fire,x,y,0,100,100,1,0,1);
	audio_sound_pitch(FireSound, random_range(0.9,1.1));	
};	
#endregion

#region Player Weapon Control Function
function PlayerWeaponControl(){	
	
	var _CanFire = (CanShoot and magazine_active > 0 and cycle);
	var _CanReload = (CanReload and !reloading);
	
	var Semi_Fire = mouse_check_button_pressed(mb_left) and (selector = "Semi" or selector = "Supercharge" or selector = "Pump");
	var Auto_Fire = mouse_check_button(mb_left) and (selector = "Auto" or selector = "Overcharge");
	var Burst_Fire = mouse_check_button(mb_left) and (string_count("Burst",selector));
	var Charge_Fire = mouse_check_button(mb_left) and (selector = "Charge"); 
	var Reload_Key = keyboard_check_pressed(ord("R"));
	var Selector_Key = keyboard_check_pressed(ord("X"));
	
	if(!mouse_check_button(mb_left)) {burst_count = 0};
	if(mouse_check_button_pressed(mb_left)) {		
		if(magazine_active = 0) {audio_play_sound_at(wpn_active.sound_group.empty,x,y,0,100,100,1,0,1)};
		if(reloading = 1 and is_array(wpn_active.animation_group.reload)) {
			skeleton_animation_clear(4);
			skeleton_anim_set_step(wpn_active.animation_group.reload[2],4);	
		};
	};
	
	if(Semi_Fire and _CanFire) {FireGun()};	
	if(Auto_Fire and _CanFire) {FireGun()};
	if(Burst_Fire and _CanFire and (burst_count < string_digits(selector))) {FireGun()};
	
	if(Reload_Key and _CanReload) {	
		reloading = 1;
		skeleton_animation_clear(2); skeleton_animation_clear(3);
		skeleton_animation_clear(4); skeleton_animation_clear(6);		
		skeleton_animation_clear(8);
		
		if(is_array(wpn_active.animation_group.reload)) {skeleton_animation_set_ext(wpn_active.animation_group.reload[0],4)};
		else{skeleton_animation_set_ext(wpn_active.animation_group.reload,4)};
	};
	
	if(Selector_Key and array_length(wpn_active.firemodes) > 1) {
	audio_play_sound(wpn_active.sound_group.selector,1,0)
	if(selector_real < array_length(wpn_active.firemodes)-1) {selector_real += 1;} else{selector_real = 0};
	selector = wpn_active.firemodes[selector_real];
	};
	
};
#endregion