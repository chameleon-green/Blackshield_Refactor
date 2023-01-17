// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Infantry create event generic

function InfantryCreateGeneric() {
	StartNode = -1;
	TargetNode = -1;
	TargetNodePrevious = -1;
	PathList = ds_list_create();
	OpenList = ds_priority_create();
	ClosedList = ds_list_create();
	ClosedParentList = ds_list_create();
	
	ClearToProcess = 0;
	
	vspd = 0;
	vspd_readonly = 0;
	hspd = 0;
	
	MoveSpeed = 12;
	JumpForce = 0;
	
	MyTarget = o_player;
	firing = 0;
	
	TargetNodeTimer = [0,irandom_range(45,60)];
	
	NewPath = 1;
	
	fleeing = 0;
	aware = 1;
	dead = 0;
	sprinting = 0;
	state = "default";
	angle = 0;
	LOSandRange = 0;
	morale = 10;
	direc = 0;
	canshoot = 1;
	reloading = 0;
	
	max_range = 6000;
	
	LOSTimer = timer_create(45,0);
	LOSCheck = 0;
	
	torsomap = ds_map_create();
	headmap = ds_map_create();
	front_bicep_map = ds_map_create();
	rear_bicep_map = ds_map_create();
	AimTimer = timer_create(8,0);
	
	SkToggle = 1;
	skeleton_bone_data_get("head",headmap);
	skeleton_bone_data_get("torso",torsomap);
	skeleton_bone_data_get("front bicep",front_bicep_map);
	skeleton_bone_data_get("rear bicep",rear_bicep_map);
			
}; //function end bracket

#endregion

#region Infantry step event generic

function InfantryStepGeneric() {
		
	//------------------------------------------- Target finding code --------------------------------------------
	
	var AI_Enabled = 1 
	aware = 1//(distance_to_object(obj_player) < radius_detection) //* AI_Enabled
	firing = 0;
	LOSCheck = timer_tick(LOSTimer,0);
	if(LOSCheck) {
		LOSandRange = check_los_and_range(1,x,y-100,MyTarget,o_platform,max_range); //can we see target, and have range?
		timer_reset(LOSTimer,1);
	}
	
	col_bot = place_meeting(x,y+2,o_platform);
	
	if(canshoot && LOSandRange && col_bot && !dead && !fleeing) {firing = 1};
	
	if(instance_exists(MyTarget) and !dead) {
		//if we are not fleeing, face our target
		if(morale > 0 and LOSandRange and !sprinting) {
		//if(target.x > x) {image_xscale = -1} else{image_xscale = 1}
		};
	
		var pl_offset = MyTarget.y+(MyTarget.bbox_top - MyTarget.bbox_bottom)/2;
		var yyy = y+(bbox_top-bbox_bottom)/2;
		direc = point_direction(x,yyy,MyTarget.x,pl_offset);
	};
 
	//--------------------------------------- Pathfinding related code -------------------------------------------------------
		
	//if we have lost LOS to player, begin to calculate a new path
	if(!LOSandRange && (ds_list_size(PathList) = 0)) {NewPath = 1};
	
	//If we are not actively engaged, and our target refresh is available, find a new target node
	TargetNodeTimer[0] += 1;
	if(firing or (TargetNodeTimer[0] > (TargetNodeTimer[1]+3) )) {TargetNodeTimer[0] = 0};
	
	if(!firing && (TargetNodeTimer[0] > TargetNodeTimer[1])) {
		TargetNodePrevious = TargetNode;
		var LOSList = ds_list_create();
		var NodesInLos = nodes_in_los(600,o_platform,o_navnode,MyTarget.x,MyTarget.y-50,-1);	
		if(NodesInLos != -1) {
			ds_list_read(LOSList,NodesInLos);	
			TargetNode = ds_list_nearest(LOSList,MyTarget.x,MyTarget.y-50,0);
		};
		ds_list_destroy(LOSList);
		TargetNodeTimer[0] = 0;
	};
	
	//Find a new path when commanded to
	if(NewPath) {
		NewPath = 0;
		if(ds_list_find_index(global.AIQueue,id) = -1) {ds_list_add(global.AIQueue,id)};
		if(ClearToProcess) {
			ClearToProcess = 0;
			//get us a new starting node for this new path
			var LOSList = ds_list_create();
			var NodesInLos = nodes_in_los(600,o_platform,o_navnode,x,y-50,-1);
			if(NodesInLos != -1) {
				ds_list_read(LOSList,NodesInLos);	
				StartNode = ds_list_nearest(LOSList,x,y-50,0);
			};
			ds_list_destroy(LOSList);
		
			var PathText = nodes_calculate_cost_array(StartNode,800,TargetNode,9999);
			ds_list_read(PathList,PathText);	
		};
	};

 //------------------------------------------- actual movement code -------------------------------------------
	
	hspd = 0;
	Left = 0;
	Right = 0;
	Jump = 0;
	
	if(!firing) {AStarMovement(PathList,ClosedList)};
	
	skeleton_anim_set_step("idle_hotshot",1)
	if(!Left && !Right) {skeleton_animation_clear(2)};
	if(Left) {image_xscale = 1 hspd = -MoveSpeed skeleton_anim_set_step("sprint_rifle",2)};
	if(Right) {image_xscale = -1 hspd = MoveSpeed skeleton_anim_set_step("sprint_rifle",2)};
	if(Jump && col_bot) {vspd = -JumpForce};
	
	vspd_readonly = vspd;

	if (place_free(x,y+sign(vspd))) {
        vspd += 1
	};

	if(place_meeting(x, y+vspd, o_platform)) { //vertical collisions
		if(vspd < 0) {move_outside_solid(270,vspd)}; //if we are going up and hit something, try to get out of ceiling collision
		else{move_contact_solid(270,10)}; //if we are going down and hit something, touch down on the floor
		vspd = 0; //kill our vertical momentum in either case
	};

	if(place_meeting(x+hspd*2,y,o_platform)){
		var MaxGrade = 3;
		var Hspd2 = hspd*+(sign(hspd)*2);
		var climb = 2; //our variable used to attempt to find a clear position to ascend to
		while(place_meeting(x+Hspd2,y-climb,o_platform) && (climb <= clamp(abs(MaxGrade*hspd),12,9100)) ) {climb += 1}; //attempts to find a clear position to ascend to, the maximum height of which is determined by our speed and maxgrade value
		if(place_meeting(x+Hspd2,y-climb+vspd,o_platform) or (vspd != 0)) { //if we fail to find a position in range of our maximum climb, the player moves forward horizontally until it hits the wall			
			move_outside_solid(180,100);
			move_outside_solid(0,100);
			hspd = 0
		};
		else{ //if we succeed in finding a clear position, move to it
			y -= climb;
			vspd_readonly = (vspd - climb);
		};
	};
	
	x += hspd;
	
	
	// Downward slopes
	if (!place_meeting(x,y,o_platform) && (vspd >= 0) && place_meeting(x,y+2+abs(hspd),o_platform)) {
		while(!place_meeting(x,y+1,o_platform)) {y += 1; vspd_readonly+=1}
	};
	
	y += vspd; //change our Y by effects of gravity and climb values
	
	
}; //function end bracket

#endregion

#region Infantry animation update generic

function InfantryAnimGeneric() {

	if(state != "dying" and state != "dead" and !reloading) {
	
		var AngOffset = 0;
		var Aim = timer_tick(AimTimer,0);
		
		if(Aim && aware and !sprinting and !dead and !fleeing) {
			
			timer_reset(AimTimer,1);
			
			skeleton_bone_state_get("torso", torsomap)
			var torso_ang = ds_map_find_value(torsomap, "angle") - 90;
			
			if(MyTarget.x > x and LOSandRange){
				image_xscale = -1;
				angle =	-direc - 180 + image_angle ;
				ds_map_replace(headmap, "angle",angle + 180);
				ds_map_replace(front_bicep_map, "angle", angle - AngOffset - torso_ang);
				ds_map_replace(rear_bicep_map, "angle", angle + clamp( (360/angle)*35, -50,50 )  );
			};
	
			else if (MyTarget.x < x and LOSandRange){
				image_xscale = 1;
				angle =	direc - image_angle ;
				ds_map_replace(headmap, "angle",angle + 180);
				ds_map_replace(front_bicep_map, "angle", angle - AngOffset - torso_ang);
				ds_map_replace(rear_bicep_map, "angle", angle - clamp( (180/angle)*35, -50,50 )  );
			};			
		};
		
		//sets values we just made
		skeleton_bone_state_set("front bicep", front_bicep_map);
		skeleton_bone_state_set("rear bicep", rear_bicep_map);
		skeleton_bone_state_set("head", headmap);			
	};
	
}; //function end bracket

#endregion

