var event = ds_map_find_value(event_data, "name");

if(ammo_active.casing_type != "none" && event = "eject") {
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

if(event = "magout") {audio_play_sound_at(wpn_active.sound_group.mag_out,x,y,0,100,100,1,0,1)};
if(event = "magin") {
	audio_play_sound_at(wpn_active.sound_group.mag_in,x,y,0,100,100,1,0,1);
	//skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment)
	};
if(event = "rackslide") {audio_play_sound_at(wpn_active.sound_group.rack_slide,x,y,0,100,100,1,0,1)};
if(event = "Reloaded") {
	reloading = 0;
	skeleton_animation_clear(4);
	if( !is_array(wpn_active.animation_group.reload)) {magazine_active = wpn_active.capacity};
};

if(event = "reload_ready") {
	skeleton_animation_clear(4);
	skeleton_animation_set_ext(wpn_active.animation_group.reload[1],4);
};

if(event = "reload_single_check" && (magazine_active >= wpn_active.capacity)) {
	skeleton_animation_clear(4); skeleton_animation_set_ext(wpn_active.animation_group.reload[2],4);
};

if(event = "reload_single") {
	if(magazine_active < wpn_active.capacity) {magazine_active += 1; audio_play_sound_at(wpn_active.sound_group.mag_in,x,y,0,100,100,1,0,1)};
};

if(event = "spinup") {
	aud_spoolup = audio_play_sound_at(wpn_active.sound_group.spinup,x,y,0,100,100,1,0,1);
	spindown_toggle = 1;
};

if(event = "spinupdone") {
	skeleton_anim_set_step(wpn_active.animation_group.fire[1],3);
	aud_spoolup = 0;
	spooled = 1;
};

if(event = "spindown") {
	aud_spooldown = audio_play_sound_at(wpn_active.sound_group.spindown,x,y,0,100,100,1,0,1);
	spindown_toggle = 0;
};

if(event = "spindowndone") {
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

if(event = "swing_light") {
	hspd = 0;
};

if(event = "swing_heavy") {
	hspd = 0;
};