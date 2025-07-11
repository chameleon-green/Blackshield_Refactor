
var event = ds_map_find_value(event_data, "name");

if(event = "Ranged/magout") {audio_play_sound(wpn_active.sound_group.mag_out,1,0)};
if(event = "Ranged/magin") {audio_play_sound_at(wpn_active.sound_group.mag_in,x,y,0,100,100,1,0,1)};	
if(event = "Ranged/rackslide") {audio_play_sound(wpn_active.sound_group.rack_slide,1,0)};

//---------------------------------------- RELOADING -----------------------------------------------

if(event = "Ranged/Reloaded") {
	reloading = 0;
	skeleton_animation_clear(4);
	//skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);
	
	if(!is_array(wpn_active.animation_group.reload)){
		var _Grid = MyIC.grd_inv_ammo;
		var _AmmoY = ds_grid_value_y(_Grid,0,0,ds_grid_width(_Grid),ds_grid_height(_Grid),ammo_active_id);
		var _AmmoPool = ds_grid_get(_Grid,1,_AmmoY);
	
		if( !is_array(wpn_active.animation_group.reload)) {		
			if(_AmmoPool > wpn_active.capacity) {magazine_active = wpn_active.capacity; ds_grid_add(_Grid,1,_AmmoY,-wpn_active.capacity)}
			else{magazine_active = _AmmoPool; ds_grid_set(_Grid,1,_AmmoY,0); ClearItem(ammo_active_id,_Grid,id)};
		};
	};
};

if(event = "Ranged/reload_ready") {
	skeleton_animation_clear(4);
	skeleton_animation_set_ext(wpn_active.animation_group.reload[1],4);
};

if(event = "Ranged/reload_single_check") {
	
	if (!is_string(ammo_active_id) or  (magazine_active >= wpn_active.capacity) ){	
		skeleton_animation_clear(4); 
		skeleton_animation_set_ext(wpn_active.animation_group.reload[2],4);
	};
};

if(event = "Ranged/reload_single") {
	if(magazine_active < wpn_active.capacity) {
		
		var _Grid = MyIC.grd_inv_ammo;
		var _AmmoY = ds_grid_value_y(_Grid,0,0,ds_grid_width(_Grid),ds_grid_height(_Grid),ammo_active_id);
		var _AmmoPool = ds_grid_get(_Grid,1,_AmmoY);
	
	    if(_AmmoPool > 1) {magazine_active += 1; ds_grid_add(_Grid,1,_AmmoY,-1); audio_play_sound(wpn_active.sound_group.mag_in,1,0)};	
		if(_AmmoPool = 1) {magazine_active += 1; ds_grid_add(_Grid,1,_AmmoY,-1); audio_play_sound(wpn_active.sound_group.mag_in,1,0); ClearItem(ammo_active_id,_Grid,id)};
	};
};

//------------------------------------------- SPINNING ----------------------------------------------------

if(event = "Ranged/spinup") {
	aud_spoolup = audio_play_sound(wpn_active.sound_group.spinup,1,0);
	spindown_toggle = 1;
};

if(event = "Ranged/spinupdone") {
	skeleton_anim_set_step(wpn_active.animation_group.fire[1],3);
	aud_spoolup = 0;
	spooled = 1;
};

if(event = "Ranged/spindown") {
	aud_spooldown = audio_play_sound(wpn_active.sound_group.spindown,1,0);
	spindown_toggle = 0;
};

if(event = "Ranged/spindowndone") {
	aud_spooldown = 0;
	skeleton_animation_clear(3);
};

//------------------------------------------ movement related events ------------------------------------

if(event = "roll_thud") {
	hspd = hspd/2
};

if(event = "roll_done") {
	skeleton_animation_clear(2);
	rolling = 0;
	hspd = 0
};

//----------------------------------------- melee related events ------------------------------------------

if(event = "Melee/swing_light" or event = "Melee/swing_heavy") {
	var rand = irandom_range(0,array_length(wpn_active_melee.sound_group.attack)-1);
	audio_play_sound(wpn_active_melee.sound_group.attack[rand],1,0);
	swing[3] = 1;
	var OIFF = IFF;
	instance_create_depth(swing[0],swing[1],depth-1,o_swing,{
		creator : id, 
		image_angle : swing[2],
		IFF : OIFF
	});
};

if(event = "Melee/stepped_melee") {
	hspd = 0;
};

if(event = "Melee/step_melee") {
	hspd = 12*image_xscale;
};