var event = ds_map_find_value(event_data, "name");

if(event = "eject") {
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
if(event = "magin") {audio_play_sound_at(wpn_active.sound_group.mag_in,x,y,0,100,100,1,0,1)};
if(event = "rackslide") {audio_play_sound_at(wpn_active.sound_group.rack_slide,x,y,0,100,100,1,0,1)};
if(event = "Reloaded") {
	reloading = 0;
	skeleton_animation_clear(4);
	magazine_active = wpn_active.capacity
};