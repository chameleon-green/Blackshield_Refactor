//checks LOS and range to specified target
//

function check_los_and_range(ai_enabled,ix,iy,target,wall_object,max_range){
	
	if(ai_enabled) {	
		var dist = distance_to_object(target); //self explanatory
		var half_target_height = abs((target.bbox_top - target.bbox_bottom)/2); //gets half of target height
		var pl_offset = target.y-half_target_height; //gets vertical center of target (if its origin is at its feet)
	
		//var map = ds_map_create();
		//skeleton_bone_state_get("muzzleflash", map); 
		var yyy = y+(bbox_top-bbox_bottom)/2; //gets center of us
	
		var NoInput = (ix = -1 and iy = -1); //if we are not provided input
	
		if(NoInput){
		//three LOS checks for head, feet and center of mass
		var LOS = collision_line(x,yyy,target.x,pl_offset,wall_object,true,1);
		var LOS2 = collision_line(x,yyy,target.x,pl_offset,wall_object,true,1);
		var LOS3 = collision_line(x,yyy,target.x,pl_offset,wall_object,true,1);
		}
	
		else {
		var LOS = collision_line(ix,iy,target.x,pl_offset,wall_object,true,1)	
		};
		
		//ds_map_destroy(map);
		
		//if at least one of our LOS is clear and we are in range, return true
		if(NoInput){
			if((!LOS or !LOS2 or !LOS3) and dist <= max_range) {return true} else{return false};
		}
	
		else if(!LOS and dist <= max_range) {return true} else{return false};
		
	};
};