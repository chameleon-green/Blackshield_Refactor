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
	
	//weapon and combat stuff
	IFF = "ENEMY1";
	firing = 0;
	reloading = 0;
	collisions_list = ds_list_create();
	death = [0,0,0]; //0=dead, 1=dying, 2=anim toggle
	
	resist_base = [0,0,0,0,0,0,0,0,0];
	resist_head = [25,0,0,0,0,0,0,0,0]; //phys0, ther1, cryo2, corr3, radi4, elec5, hazm6, warp7
	resist_torso = [25,0,0,0,0,0,0,0,0];
	resist_armL = [17,0,0,0,0,0,0,0,0];
	resist_armR = [17,0,0,0,0,0,0,0,0];
	resist_legL = [17,0,0,0,0,0,0,0,0];
	resist_legR = [17,0,0,0,0,0,0,0,0];

	hbox_head = [-25,135,25,105];
	hbox_torso = [-30,105,30,60];
	hbox_legs = [-30,60,30,0];
	
	hp_body_head_max = 12;
	hp_body_torso_max = 38;
	hp_body_armL_max = 16;
	hp_body_armR_max = 16;
	hp_body_legL_max = 23;
	hp_body_legR_max = 23;
	max_hp = hp_body_head_max + hp_body_torso_max + hp_body_armL_max + hp_body_armR_max + hp_body_legL_max + hp_body_legR_max;
	
	hp_body_head = hp_body_head_max;
	hp_body_torso = hp_body_torso_max;
	hp_body_armL = hp_body_armL_max;
	hp_body_armR = hp_body_armR_max;
	hp_body_legL = hp_body_legL_max;
	hp_body_legR = hp_body_legR_max;
	HP = max_hp;
	
	/*initialize armor item and ratio arrays. 
	0 = item struct, 
	1 = item uniqueid, (UNUSED) 
	2 = armor ratio (clamped), used for minimum armor effectiveness at 0 durability 
	3 = armor ratio (unclamped), raw ratio used for UI 
	4 = limb per frame damage (for amputations)
	5 = limb is amputated (true or false)
	*/
	
	armor_head = ["none",-1,1,0,0,false];
	armor_torso = ["none",-1,1,0,0,false];
	armor_armL = ["none",-1,1,0,0,false];
	armor_armR = ["none",-1,1,0,0,false];
	armor_legL = ["none",-1,1,0,0,false];
	armor_legR = ["none",-1,1,0,0,false];
		
	weapon_ranged = o_IC.Lasgun_Kantrael;	
	ammo_type_primary = o_IC.Lasgun_Kantrael.default_ammo_type;
	current_mag = weapon_ranged.capacity;
	burst_size_base = clamp(weapon_ranged.capacity/30,1,40);
	burst_size = clamp(burst_size_base+irandom_range(-burst_size_base,burst_size_base),1,40);
	burst_count = 0;
	burst_ready = 1;
	
	burst_timer = timer_create(600,false);	
	cycle_timer = timer_create(weapon_ranged.ROF,false);
	
	// Pathfinding stuff
	MyTarget = o_player;
	TargetNodeTimer = [0,irandom_range(8,15)];
	
	NewPath = 0;
	NewPathToggle = 1;
	
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
	
	max_range = (weapon_ranged.range);
	
	LOSTimer = timer_create(45,0);
	LOSCheck = 0;
	
	torsomap = ds_map_create();
	headmap = ds_map_create();
	front_bicep_map = ds_map_create();
	rear_bicep_map = ds_map_create();
	AimTimer = timer_create(8,0);

	skeleton_bone_data_get("head",headmap);
	skeleton_bone_data_get("torso",torsomap);
	skeleton_bone_data_get("front bicep",front_bicep_map);
	skeleton_bone_data_get("rear bicep",rear_bicep_map);
			
}; //function end bracket

#endregion

#region Infantry step event generic

function InfantryStepGeneric() {
	
	
	
	//----------------------------------------------- Impact Code ---------------------------------------
	if(death[0] != 1) {
		ImpactScript(o_bullet,"head",hbox_head,collisions_list);
		ImpactScript(o_bullet,["torso","torso","torso","torso","armL","armL","armR","armR"],hbox_torso,collisions_list);
		ImpactScript(o_bullet,["legL","legR"],hbox_legs,collisions_list);
	};
	
	//-------------------------------------------------- Death States ---------------------------------------
	
	HP = hp_body_head + hp_body_torso + hp_body_armL + hp_body_armR + hp_body_legL + hp_body_legR;
	if(HP <= 0) {death[1] = 1};
	
	if(((armor_head[5] = true) or (armor_torso[5] = true)) && (death[2] = 0)) {
		skeleton_attachment_set("head",-1);
		death[1] = 1;
		
		var gib_map = ds_map_create();
		skeleton_bone_state_get("head", gib_map);
		var EjectX = ds_map_find_value(gib_map, "worldX");
		var EjectY = ds_map_find_value(gib_map, "worldY");
		//var EjectAng = ds_map_find_value(ejection_map, "worldAngleX");
		
		var gib_count = 0;
		while(gib_count < 6) {
			instance_create_depth(EjectX,EjectY,depth+1,o_gib,{
				sprite_index : sp_gibs_human,
				image_index : gib_count,
				hspd : choose(irandom_range(1,7),-irandom_range(1,7)),
				vspd : -random_range(12,14),
				angspeed : irandom_range(-25,25),
				impact_sound : snd_impact_gore1,
				impact_sound_pitch : 1
			});
			gib_count+=1;
		};
		instance_create_depth(EjectX,EjectY,depth-1,oprt_splatter);
	ds_map_destroy(gib_map);
		
	};
	
	if((death[1] = 1) && (death[2] = 0)) {
		death[2] = 1;
		death[0] = 1;
		skeleton_animation_clear(1);
		skeleton_animation_clear(2);
		skeleton_anim_set_step(choose("die_1","die_2"),1,false);
	};
	
	var Dead = (death[0] = 1);
	var Dying = (death[1] = 1);
	
	//------------------------------------------- Target finding code --------------------------------------------
	
	if(!Dead) {
		var AI_Enabled = 1 
		aware = 1//(distance_to_object(obj_player) < radius_detection) //* AI_Enabled
		firing = 0;
		LOSCheck = timer_tick(LOSTimer,0);
		if(LOSCheck) {
			LOSandRange = check_los_and_range(1,x,y-100,MyTarget,o_platform,max_range); //can we see target, and have range?
			timer_reset(LOSTimer,1);
		}
	
		col_bot = place_meeting(x,y+2,o_platform);
	
		if(canshoot && LOSandRange && col_bot && !fleeing) {firing = 1};
	
		if(instance_exists(MyTarget)) {
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
		if(!LOSandRange and (ds_list_size(PathList) = 0)) {NewPath = 1};
		if(LOSandRange and col_bot) {ds_list_clear(PathList); NewPath = 0};
	
	
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
			//ClearToProcess = 0;
			if(ds_list_find_index(o_IC.AIQ,id) = -1 and !ClearToProcess) {ds_list_add(o_IC.AIQ,id)};
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
	};	
//------------------------------------------- actual movement code -------------------------------------------
	
	hspd = 0;
	Left = 0;
	Right = 0;
	Jump = 0;
	
	if(!Dead) {
		if(!firing) {AStarMovement(PathList,ClosedList,MoveSpeed,NewPath)};	
		skeleton_anim_set_step("idle_hotshot",1)
		if(!Left && !Right) {skeleton_animation_clear(2)};
		if(Left) {image_xscale = 1 hspd = -MoveSpeed skeleton_anim_set_step("sprint_rifle",2)};
		if(Right) {image_xscale = -1 hspd = MoveSpeed skeleton_anim_set_step("sprint_rifle",2)};
		if(Jump && col_bot) {vspd = -JumpForce};
	};
	
	vspd_readonly = vspd;

	if (place_free(x,y+sign(vspd))) {
        vspd += 1
	};

	if(place_meeting(x, y+vspd, o_platform)) { //vertical collisions
		if(vspd < 0) {move_outside_solid(270,vspd)} //if we are going up and hit something, try to get out of ceiling collision
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
		}
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
	
//------------------------------------------------- Ranged Combat Code -----------------------------------------------

	if(firing && !Dead) {
		
		if(burst_count >= burst_size) {burst_ready = timer_tick(burst_timer,1)};
		if(burst_ready) {
			burst_count = 0;
			burst_ready = 0; 
			timer_reset(burst_timer,1);
			timer_reset(cycle_timer,1);
			var BurstBase = clamp(weapon_ranged.capacity/10,1,40);
			var BurstModified = BurstBase + irandom_range(-BurstBase/2, BurstBase/2);
			burst_size = clamp(BurstModified,1,50);
			
			var DistRatio = clamp(point_distance(x,y,MyTarget.x,MyTarget.y)/2000,0.01,1);
			burst_timer = timer_create(100*DistRatio,false);			
		};
		
		var Shoot = (timer_tick(cycle_timer,0) and (burst_count < burst_size));
		if(Shoot) {
			
			var FlashMap = "none";	
			if(visible){
				FlashMap = ds_map_create();		
				skeleton_bone_state_get("muzzleflash", FlashMap);
				var FlashX = ds_map_find_value(FlashMap, "worldX");
				var FlashY = ds_map_find_value(FlashMap, "worldY");
			}
			else{var FlashX = x var FlashY = bbox_top};
			
			instance_create_depth(FlashX,FlashY,depth-1,o_bullet,{
				direction : direc + random_range(-other.weapon_ranged.spread,other.weapon_ranged.spread),
				speed : weapon_ranged.muzzle_velocity,
				type : ammo_type_primary,
				damage : weapon_ranged.damage,
				IFF : other.IFF,
				vspd : other.vspd_readonly,
				hspd : other.hspd,
				creator : other.id,
				origin_x : FlashX,
				origin_y : FlashY
			});
			burst_count += 1;
			
			if(FlashMap != "none") {ds_map_destroy(FlashMap)};
			timer_reset(cycle_timer,1);
		};
	};
	
	
	
}; //function end bracket

#endregion

#region Infantry animation update generic

function InfantryAnimGeneric() {
	
	var Dead = (death[0] = 1);
	var Dying = (death[1] = 1);
	
	if(visible && !Dead and !Dying and !reloading and LOSandRange) {
	
		var AngOffset = 0;
		var Aim = timer_tick(AimTimer,0);
		
		if(Aim && aware and !sprinting and !dead and !fleeing) {
			
			timer_reset(AimTimer,1);
			
			skeleton_bone_state_get("torso", torsomap)
			var torso_ang = ds_map_find_value(torsomap, "angle") - 90;
			
			if((MyTarget.x > x) and LOSandRange){
				image_xscale = -1;
				angle =	-direc - 180 + image_angle ;
				ds_map_replace(headmap, "angle",angle + 180);
				ds_map_replace(front_bicep_map, "angle", angle - AngOffset - torso_ang);
				ds_map_replace(rear_bicep_map, "angle", angle + clamp( (360/angle)*35, -50,50 )  );
			}
	
			else if ((MyTarget.x < x) and LOSandRange){
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

#region Infantry animation event generic

function InfantryEventGeneric() {
	
	var event = ds_map_find_value(event_data, "name");
		
}; //function end bracket

#endregion
	