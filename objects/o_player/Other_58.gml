
if(CanShoot) {
	var torso_map = ds_map_create();
	var head_map = ds_map_create();
	var front_bicep_map = ds_map_create();
	var front_forearm_map = ds_map_create();
	var front_hand_map = ds_map_create();
	var gun_map = ds_map_create();
	var rear_bicep_map = ds_map_create();
	var rear_forearm_map = ds_map_create();
	var flash_map = ds_map_create();
	var AngOffset = wpn_active.angular_offset;
	var YOffset = wpn_active.vertical_offset;
	
	skeleton_bone_state_get("head", head_map);
	skeleton_bone_state_get("torso", torso_map);
	skeleton_bone_state_get("front forearm", front_forearm_map);
	skeleton_bone_state_get("front hand", front_hand_map);
	skeleton_bone_state_get("front bicep", front_bicep_map);
	skeleton_bone_state_get("muzzleflash", flash_map);
	
	flash_angle = ds_map_find_value(flash_map, "worldAngleX");
	flash_x = ds_map_find_value(flash_map, "worldX");
	flash_y = ds_map_find_value(flash_map, "worldY");
	torsoX = ds_map_find_value(torso_map, "worldX");
	torsoY = ds_map_find_value(torso_map, "worldY");
	
	delta_x2 = mouse_x - x//torsoX; //actual delta
	delta_y2 = mouse_y - y//torsoY; //actual delta
	
	AimAngle2 = -radtodeg(arctan2(delta_y2,delta_x2));
	AimAngleCorrected = (AimAngle2*image_xscale) + (90*image_xscale) + instant_spread;
	
	//-----------------------------------------------------------------------------------------------
	
	ds_map_replace(front_forearm_map, "angle", AimAngleCorrected);
	skeleton_bone_state_set("front forearm", front_forearm_map);
	
	//kill the maps we created to avoid memory leaks
	ds_map_destroy(torso_map);
	ds_map_destroy(head_map);
	ds_map_destroy(front_bicep_map);
	ds_map_destroy(front_forearm_map);
	ds_map_destroy(front_hand_map);
	ds_map_destroy(gun_map);
	ds_map_destroy(rear_bicep_map);
	ds_map_destroy(rear_forearm_map);
	ds_map_destroy(flash_map);
};