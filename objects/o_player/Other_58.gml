if(swinging or wpn_active != wpn_primary && !reloading) {
	skeleton_attachment_set("slot_melee_weapon",wpn_active_melee.weapon_attachment)
};


var HitPointMap = ds_map_create();
	skeleton_bone_state_get("melee hitpoint",HitPointMap);	
	swing[0] = ds_map_find_value(HitPointMap, "worldX");
	swing[1] = ds_map_find_value(HitPointMap, "worldY");
	swing[2] = -ds_map_find_value(HitPointMap, "worldAngleY")
	ds_map_destroy(HitPointMap);	

if(swinging) {	
	
};


if(CanShoot = 1) {
	var torso_map = ds_map_create();
	var head_map = ds_map_create();
	var front_bicep_map = ds_map_create();
	var front_forearm_map = ds_map_create();
	var front_hand_map = ds_map_create();
	var gun_map = ds_map_create();
	var rear_bicep_map = ds_map_create();
	var rear_forearm_map = ds_map_create();
	var flash_map = ds_map_create();
	
	skeleton_bone_state_get("head", head_map);
	skeleton_bone_state_get("torso", torso_map);
	skeleton_bone_state_get("front forearm", front_forearm_map);
	skeleton_bone_state_get("front hand", front_hand_map);
	skeleton_bone_state_get("front bicep", front_bicep_map);
	skeleton_bone_state_get("muzzleflash", flash_map);
	
	flash_angle = ds_map_find_value(flash_map, "worldAngleX");
	flash_x = ds_map_find_value(flash_map, "worldX");
	flash_y = ds_map_find_value(flash_map, "worldY");
	torso_angle = ds_map_find_value(torso_map, "worldAngleX");
	//torsoX = ds_map_find_value(torso_map, "worldX");
	//torsoY = ds_map_find_value(torso_map, "worldY");
	
	delta_x2 = mouse_x - x;//torsoX; //actual delta
	delta_y2 = mouse_y - y;//torsoY; //actual delta
	
	var TorsoAngOffset = (90+torso_angle)*image_xscale;
	AimAngleBullet = -radtodeg(arctan2(delta_y2,delta_x2));
	AimAngleCorrected = -radtodeg(arctan2(delta_y2,abs(delta_x2))) + 90 + wpn_active.angular_offset + instant_spread + TorsoAngOffset;
	var Head_Angle = -radtodeg(arctan2(delta_y2,abs(delta_x2))) + TorsoAngOffset;
	
	//-----------------------------------------------------------------------------------------------
	
	var Rear_Bicep_Mult = 1.15;
	
	var CorrectedAngle = (AimAngleCorrected - wpn_active.angular_offset - TorsoAngOffset);
	if(wpn_active.angular_offset = 90)	{
		var Rear_Bicep_Mult = 1 + (CorrectedAngle/1200);
	};
	
	ds_map_replace(head_map, "angle", clamp(Head_Angle,-30,30));
	skeleton_bone_state_set("head", head_map);
	
	//this offers an alternate aiming anim for rifle type-weapons when aiming downwards 
	if( wpn_active.angular_offset = 90 && (AimAngleCorrected - wpn_active.angular_offset - TorsoAngOffset) < 35) {
		AimAngleCorrected = -radtodeg(arctan2(delta_y2,abs(delta_x2))) + 270  + TorsoAngOffset;//(AimAngleBullet*image_xscale) + (90*image_xscale) + instant_spread;
		ds_map_replace(front_forearm_map, "angle", 0);
		skeleton_bone_state_set("front forearm", front_forearm_map);
		
		if(wpn_active.weapon_slot[1] = 2) {
		ds_map_replace(rear_forearm_map, "angle", 10);
		skeleton_bone_state_set("rear forearm", rear_forearm_map);
		};
		Rear_Bicep_Mult = 0.9
	};
	
	ds_map_replace(front_bicep_map, "angle", AimAngleCorrected);
	skeleton_bone_state_set("front bicep", front_bicep_map);
	
	if(wpn_active.weapon_slot[1] = 2) {
	ds_map_replace(rear_bicep_map, "angle", AimAngleCorrected * Rear_Bicep_Mult);
	skeleton_bone_state_set("rear bicep", rear_bicep_map);
	};
	
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

 