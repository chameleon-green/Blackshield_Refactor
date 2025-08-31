// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information



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
	col_bot  = 0;
	
	MoveSpeed = 12;
	JumpForce = 0;
	
	//weapon and combat stuff
	IFF = "ENEMY1";
	firing = 0;
	reloading = 0;
	collisions_list = ds_list_create();
	death = [0,0,0]; //0=dead, 1=dying, 2=anim toggle
	
	hbox_head = [-25,133,25,107];
	hbox_torso = [-35,107,35,57];
	hbox_legs = [-35,57,35,0];
	
	hp_body_head_max = 11;
	hp_body_torso_max = 28;
	hp_body_armL_max = 12;
	hp_body_armR_max = 12;
	hp_body_legL_max = 14;
	hp_body_legR_max = 14;
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
	6 = limb hp ratio
	7 = max armor durability
	8 = remaining armor durability
	*/
	
	armor_head = ["none",-1,1,0,0,false,1,300,300];
	armor_torso = ["none",-1,1,0,0,false,1,300,300];
	armor_armL = ["none",-1,1,0,0,false,1,200,200];
	armor_armR = ["none",-1,1,0,0,false,1,200,200];
	armor_legL = ["none",-1,1,0,0,false,1,200,200];
	armor_legR = ["none",-1,1,0,0,false,1,200,200];

	resist_base = [3,0,0,0,0,0,0,0,0];
	resist_head = [0,0,0,0,0,0,0,0,0]; //phys0, ther1, cryo2, corr3, radi4, elec5, hazm6, warp7
	resist_torso = [0,0,0,0,0,0,0,0,0];
	resist_armL = [0,00,0,0,0,0,0,0,0];
	resist_armR = [0,00,0,0,0,0,0,0,0];
	resist_legL = [0,00,0,0,0,0,0,0,0];
	resist_legR = [0,00,0,0,0,0,0,0,0];
		
	resist_base = [0,0,0,0,0,0,0,0,0];
	resist_head = [18,28,0,0,0,0,0,0,0]; //phys0, ther1, cryo2, corr3, radi4, elec5, hazm6, warp7
	resist_torso = [18,28,0,0,0,0,0,0,0];
	resist_armL = [12,20,0,0,0,0,0,0,0];
	resist_armR = [12,20,0,0,0,0,0,0,0];
	resist_legL = [7,20,0,0,0,0,0,0,0];
	resist_legR = [7,20,0,0,0,0,0,0,0];
	
	resist_base = [0,0,0,0,0,0,0,0,0];
	resist_head = [35,35,0,0,0,0,0,0,0]; //phys0, ther1, cryo2, corr3, radi4, elec5, hazm6, warp7
	resist_torso = [55,35,0,0,0,0,0,0,0];
	resist_armL = [35,25,0,0,0,0,0,0,0];
	resist_armR = [35,25,0,0,0,0,0,0,0];
	resist_legL = [19,25,0,0,0,0,0,0,0];
	resist_legR = [19,25,0,0,0,0,0,0,0];
	
	weapon_ranged = o_IC.Lasgun_Kantrael //o_IC.Autogun_Agrippina3//o_IC.Autogun_Mosin;//;
	ammo_type_primary = weapon_ranged.default_ammo_type; //o_IC.Lasgun_Kantrael.default_ammo_type;
	current_mag = weapon_ranged.capacity;
	burst_size_base = clamp(weapon_ranged.capacity/30,1,40);
	burst_size = clamp(burst_size_base+irandom_range(-burst_size_base,burst_size_base),1,40);
	burst_count = 0;
	burst_ready = 1;
	
	burst_timer = timer_create(900,false);	
	cycle_timer = timer_create(weapon_ranged.ROF*1,false);
	aim_toggle = 1;
	aim_toggle_timer = timer_create(1,0);
	aimYoffset = irandom_range(-30,30);
	
	spread_angle = 0;
	
	// Pathfinding stuff
	MyTarget = o_player;
	TargetNodeTimer = timer_create(irandom_range(10,20),0);
	
	NewPath = 0;
	NewPathToggle = 1;
	RepathTimer = timer_create(200,1); //a timer to see if we have progressed our path
	LastKnownNode = [-1,-1]; //the last known nodes in our path, used by repathtimer
	
	fleeing = 0;
	aware = 1;
	dead = 0;
	sprinting = 0;
	state = "default";
	angle = 0;
	LOSandRange = 0;
	morale = 100;
	direc = 0;
	canshoot = 1;
	reloading = 0;
	
	//suppression stuff
	suppression_level = 0;
	suppression_check_timer = timer_create(15,0);
	suppression_reset_timer = timer_create(25,0);
	
	max_range = (weapon_ranged.range);
	
	LOSTimer = timer_create(45,0);
	LOSCheck = 0;
	
	//torsomap = ds_map_create();
	//headmap = ds_map_create();
	//front_bicep_map = ds_map_create();
	//rear_bicep_map = ds_map_create();
	AimTimer = timer_create(1,0);

	//skeleton_bone_data_get("head",headmap);
	//skeleton_bone_data_get("torso",torsomap);
	//skeleton_bone_data_get("front bicep",front_bicep_map);
	//skeleton_bone_data_get("rear bicep",rear_bicep_map);
			
}; //function end bracket

function InfantryStepGeneric() {
	
	//----------------------------------------------- Impact Code ---------------------------------------
	if(death[0] != 1) {
		ImpactScript(o_bullet,"head",hbox_head,collisions_list,1);
		ImpactScript(o_bullet,["torso","torso","torso","torso","armL","armL","armR","armR"],hbox_torso,collisions_list,1);
		ImpactScript(o_bullet,["legL","legR"],hbox_legs,collisions_list,1);
	};
	
	//-------------------------------------------------- Death States ---------------------------------------
	
	HP = hp_body_head + hp_body_torso + hp_body_armL + hp_body_armR + hp_body_legL + hp_body_legR;
	if(HP <= 0) {death[1] = 1};
	
	if(((armor_torso[5] = true)) && (death[2] = 0)) {
		skeleton_attachment_set("head",-1);
		skeleton_attachment_set("torso",-1);
		skeleton_attachment_set("backpack",-1);
		skeleton_attachment_set("front bicep",-1);
		skeleton_attachment_set("rear bicep",-1);
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
		
		skeleton_bone_state_get("torso", gib_map);
		var EjectX = ds_map_find_value(gib_map, "worldX");
		var EjectY = ds_map_find_value(gib_map, "worldY");
		
		var gib_count = 0;
		while(gib_count < 8) {
			instance_create_depth(EjectX,EjectY,depth+1,o_gib,{
				sprite_index : sp_gibs_human,
				image_index : irandom_range(7,14),
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
	
	
	if(((armor_head[5] = true)) && (death[2] = 0)) {
		skeleton_attachment_set("head",-1);
		death[1] = 1;
		
		var gib_map = ds_map_create();
		skeleton_bone_state_get("head", gib_map);
		var EjectX = ds_map_find_value(gib_map, "worldX");
		var EjectY = ds_map_find_value(gib_map, "worldY");
		//var EjectAng = ds_map_find_value(ejection_map, "worldAngleX");
		
		var gib_count = 0;
		while(gib_count < 8) {
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
		skeleton_animation_clear(3);
		skeleton_animation_clear(4);
		skeleton_anim_set_step(choose("die_1","die_2"),1,false);
		reloading = 0;
		mask_index = spr_collision_mask_human_dead;
	};
	
	var Dead = (death[0] = 1);
	var Dying = (death[1] = 1);
	
	//------------------------------------------- Suppression Code ------------------------------------------------
	/*
	var CheckSuppression = timer_tick(suppression_check_timer,0);
	var ResetSuppression = timer_tick(suppression_reset_timer,0);
	if(CheckSuppression) {
		var List = ds_list_create();
		collision_circle_list(x,y,1800,[o_explosion_scalable,o_fragment,o_bullet],false,true,List,true);
		var ListSize = ds_list_size(List);
		if(ListSize > 0){
			var i = 0;
			while (i < (ListSize-1)){
				var Item = ds_list_find_value(List,i);
				if(Item.object_index = o_bullet) {
					if(Item.IFF != IFF) {
					suppression_level = clamp(suppression_level+1,0,25)
					};
				};
			i++;
			};
		};
	
	ds_list_destroy(List);	
	timer_reset(suppression_check_timer,1);
	};
	
	if(ResetSuppression) {
		if(suppression_level > 0) {suppression_level -= 1}; 
		timer_reset(suppression_reset_timer,1);
		};
	*/
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
	
		if(canshoot and LOSandRange and col_bot and !fleeing) {firing = 1};
	
		if(instance_exists(MyTarget)) {
			//if we are not fleeing, face our target
			if(morale > 0 and LOSandRange and !sprinting) {
			//if(target.x > x) {image_xscale = -1} else{image_xscale = 1}
			};
	
			var pl_offset = 20+MyTarget.y+(MyTarget.bbox_top - MyTarget.bbox_bottom)/2;
			var yyy = y+(bbox_top-bbox_bottom)/2;
			direc = point_direction(x,yyy+aimYoffset,MyTarget.x,pl_offset);
		};

	//--------------------------------------- Pathfinding related code -------------------------------------------------------
		
		//if we have lost LOS to player, begin to calculate a new path
		if(!LOSandRange and (ds_list_size(PathList) = 0)) {NewPath = 1};
		if(LOSandRange and col_bot) {ds_list_clear(PathList); NewPath = 0};
	
	
		//If we are not actively engaged, and our target refresh is available, find a new target node
		var TargetNodeTick = 0;
		if(!firing) {TargetNodeTick = timer_tick(TargetNodeTimer,0)};
		
		if(!firing and TargetNodeTick) {
			TargetNodePrevious = TargetNode;
			var LOSList = ds_list_create();
			var NodesInLos = nodes_in_los(3600,o_platform,o_navnode,MyTarget.x,MyTarget.y-50,-1);	
			if(NodesInLos != -1) {
				ds_list_read(LOSList,NodesInLos);	
				TargetNode = ds_list_nearest(LOSList,MyTarget.x,MyTarget.y-50,0);
			};
			ds_list_destroy(LOSList);
			TargetNodeTimer[0] = 0;
		};
		
		//if we have not reached our next node for a specified period, generate a new path
		var RepathCheck = timer_tick(RepathTimer,1);
		LastKnownNode[0] = ds_list_find_value(PathList,0);
		if(RepathCheck) {
			timer_reset(RepathTimer,0);
			LastKnownNode[1] = ds_list_find_value(PathList,0);
			if(LastKnownNode[0] = LastKnownNode[1]) {NewPath = 1};
		};

		
	
		//Find a new path when commanded to
		if(NewPath) {	
			NewPath = 0;
		
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
				
				//get us a new target node for this new path
				var LOSList = ds_list_create();
				var NodesInLos = nodes_in_los(3600,o_platform,o_navnode,MyTarget.x,MyTarget.y-50,-1);	
				if(NodesInLos != -1) {
					ds_list_read(LOSList,NodesInLos);	
					TargetNode = ds_list_nearest(LOSList,MyTarget.x,MyTarget.y-50,0);
				};
				ds_list_destroy(LOSList);
		
				var PathText = nodes_calculate_cost_array(StartNode,800,TargetNode,9999);
				ds_list_read(PathList,PathText);	
			};
		};
	};	
	
//++++++++++++++++++++++++++++++++++++++++++++++++++ COLLISIONS FOR STOPPING STACKING ++++++++++++++++++++++

//if(hspeed != 0 and !dead and !fleeing) {
	if(!death[0] and !fleeing) {

	
		var clist = ds_list_create();
		collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,o_enemy,false,true,clist,true);
		var _count = ds_list_size(clist);
		var _max = 0;
	
		//if(target_node != 0 and instance_exists(target_node)){
		//if(target_node.cover = 1 and !place_meeting(x,y,obj_cover)) { _max = 1}
		//}
	
		//if(_count > _max and !seeking_cover) {
		if(_count > _max) {
	
			var npc = ds_list_find_value(clist,0);
			var still_me = (hspd = 0);
			var same_target = (TargetNode = npc.TargetNode);
			if(npc.hspd = 0 and !npc.death[0] and npc.col_bot = 1 and same_target) {  
				var facing = (x < npc.x);
				if(facing = 1) { //enemy is to our right
					npc.x+=MoveSpeed*1.5;
					x-=MoveSpeed*1.5*still_me;
				}
				else{
					npc.x-=MoveSpeed*1.5;
					x+=MoveSpeed*1.5*still_me;
				};		
			};
		};
	
	ds_list_destroy(clist);
	};

//------------------------------------------- actual movement code -------------------------------------------
	
	hspd = 0;
	Left = 0;
	Right = 0;
	Jump = 0;
	
	if(!Dead) {
		if(!firing) {AStarMovement(PathList,ClosedList,MoveSpeed,NewPath)};	
		skeleton_anim_set_step(weapon_ranged.animation_group.idle,1)
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
	
	if(aim_toggle = 0) {aim_toggle = timer_tick(aim_toggle_timer,1)};
	
	if(current_mag = 0 ) {		
			if(skeleton_animation_get_ext(3) = "" and !fleeing and !Dead and !reloading) {
				reloading = 1;
				skeleton_anim_set_step(weapon_ranged.animation_group.reload,4);
			};
	};
	
	if(firing and !Dead) {
		
		if(burst_count >= burst_size) {
			//var FiringFrames = skeleton_animation_get_frames(weapon_ranged.animation_group.fire);
			//var CurrentFrame = skeleton_animation_get_frame(3);
			//if(CurrentFrame >= FiringFrames-1) {skeleton_animation_clear(3)};
			burst_ready = timer_tick(burst_timer,1)
		};
			
		if(burst_ready and current_mag > 0) {
			burst_count = 0;
			burst_ready = 0; 
			timer_reset(burst_timer,1);
			timer_reset(cycle_timer,1);
			var BurstBase = clamp(weapon_ranged.capacity/10,1,40);
			var BurstModified = BurstBase + irandom_range(-BurstBase/2, BurstBase/2);
			burst_size = clamp(BurstModified,1,current_mag);
			
			var FiringFrames = skeleton_animation_get_frames(weapon_ranged.animation_group.fire)
			var DistRatio = clamp(point_distance(x,y,MyTarget.x,MyTarget.y)/2000,0.01,1);
			burst_timer = timer_create(clamp((100*DistRatio)+(5*suppression_level),FiringFrames,999999),false);			
		};
		
		var Shoot = (timer_tick(cycle_timer,0) and (burst_count < burst_size) and (current_mag > 0) );
		
		if(Shoot) {
			
			aimYoffset = irandom_range(-30,30);
			current_mag -= 1;
			
			var FlashMap = "none";	
			if(visible){
				FlashMap = ds_map_create();		
				skeleton_bone_state_get("muzzleflash", FlashMap);
				var FlashX = ds_map_find_value(FlashMap, "worldX");
				var FlashY = ds_map_find_value(FlashMap, "worldY");
			}
			else{var FlashX = x var FlashY = bbox_top};
			
			alarm[2] = skeleton_animation_get_frames(weapon_ranged.animation_group.fire)-1;
			skeleton_animation_set_ext(weapon_ranged.animation_group.fire,3);
			
			var SupAngle = clamp(suppression_level,0,25)/3;
			spread_angle = burst_count*weapon_ranged.spread*3 ;
			
			instance_create_depth(FlashX,FlashY,depth+1,o_bullet,{
				direction : direc + random_range(-spread_angle,spread_angle) + random_range(-SupAngle,SupAngle),
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
			
			
			var ArraySize = array_length(weapon_ranged.sound_group.fire);
			var i = irandom_range(0,ArraySize-1);
			var FireSound = audio_play_sound_at(weapon_ranged.sound_group.fire[i],x,y,0,1000,4000,1,0,1);
			audio_sound_pitch(FireSound, random_range(0.85,1.05));	
			
			if(weapon_ranged.flash_type != "none") {
			var flash = irandom(3);
			if(ammo_type_primary.flash_color != "none") {skeleton_slot_color_set("slot_flash",ammo_type_primary.flash_color[0],1)}
			else {skeleton_slot_color_set("slot_flash",weapon_ranged.flash_color[0],1)};
			skeleton_attachment_set("slot_flash",weapon_ranged.flash_type[flash]);
			skeleton_attachment_set("slot_flash_core",weapon_ranged.flash_type[flash] + " core");
			};
			
			alarm[1] = 2;
			
			if(FlashMap != "none") {ds_map_destroy(FlashMap)};
			timer_reset(cycle_timer,1);
		};
	};
	
}; //function end bracket

function InfantryAnimGeneric() {
	
	var Dead = (death[0] = 1);
	var Dying = (death[1] = 1);
	
	if(visible and !Dead and !Dying and !reloading and LOSandRange and aim_toggle) {
		
		
		var torso_map = ds_map_create();
		var head_map = ds_map_create();
		var front_bicep_map = ds_map_create();
		var front_forearm_map = ds_map_create();
		var front_hand_map = ds_map_create();
		var gun_map = ds_map_create();
		var rear_bicep_map = ds_map_create();
		var rear_forearm_map = ds_map_create();
		var flash_map = ds_map_create();
	
		var AngOffset = 0;
		var Aim = timer_tick(AimTimer,0);
		
		if(Aim && aware and !sprinting and !dead and !fleeing) {
			
			timer_reset(AimTimer,1);
			
			skeleton_bone_state_get("torso", torso_map)
			var torso_ang = ds_map_find_value(torso_map, "angle") - 90;
			
			if((MyTarget.x > x) and LOSandRange){
				image_xscale = -1;
				angle =	-direc - 180 + image_angle ;
				ds_map_replace(head_map, "angle",angle + 180);
				ds_map_replace(front_bicep_map, "angle", angle - AngOffset - torso_ang);
				ds_map_replace(rear_bicep_map, "angle", angle + clamp( (360/angle)*35, -50,50 )  );
			}
	
			else if ((MyTarget.x < x) and LOSandRange){
				image_xscale = 1;
				angle =	direc - image_angle ;
				ds_map_replace(head_map, "angle",angle + 180);
				ds_map_replace(front_bicep_map, "angle", angle - AngOffset - torso_ang);
				ds_map_replace(rear_bicep_map, "angle", angle - clamp( (180/angle)*35, -50,50 )  );
			};			
		};
		
		//sets values we just made
		skeleton_bone_state_set("front bicep", front_bicep_map);
		skeleton_bone_state_set("rear bicep", rear_bicep_map);
		skeleton_bone_state_set("head", head_map);
		
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
	
}; //function end bracket

function InfantryEventGeneric() {
	
	var event = ds_map_find_value(event_data, "name");
	
	if(event = "reloaded") {
		current_mag = weapon_ranged.capacity;
		skeleton_animation_clear(4);
		reloading = 0;	
	};
	
	if(event = "magout") {audio_play_sound(weapon_ranged.sound_group.mag_out,1,0)};
	if(event = "magin") {audio_play_sound_at(weapon_ranged.sound_group.mag_in,x,y,0,100,100,1,0,1)};	
	if(event = "rackslide") {audio_play_sound(weapon_ranged.sound_group.rack_slide,1,0)};

	//---------------------------------------- EJECTING ------------------------------------------------
	if(event = "eject") {
		if(ammo_type_primary.casing_type != "none" ) {
			var ejection_map = ds_map_create();
			skeleton_bone_state_get("gun_anim", ejection_map);
			var EjectX = ds_map_find_value(ejection_map, "worldX");
			var EjectY = ds_map_find_value(ejection_map, "worldY");
			//var EjectAng = ds_map_find_value(ejection_map, "worldAngleX");

			instance_create_depth(EjectX,EjectY,depth-1,o_gib,{
				sprite_index : other.ammo_type_primary.casing_type[0],
				image_index : other.ammo_type_primary.casing_type[1],
				hspd : irandom_range(8,12)*other.image_xscale,
				vspd : -random_range(3,5),
				angspeed : irandom_range(-25,25),
				impact_sound : other.ammo_type_primary.casing_sound[0],
				impact_sound_pitch : other.ammo_type_primary.casing_sound[1]
			});

		ds_map_destroy(ejection_map);
		}; // eject event end
	};
	
	if(event = "aim_toggle" and aim_toggle = 1) {
		var FiringFrames = skeleton_animation_get_frames(weapon_ranged.animation_group.fire);
		var CurrentFrame = skeleton_animation_get_frame(3);
		var FramesRemaining = FiringFrames - CurrentFrame;
		timer_reset(aim_toggle_timer,1);
		aim_toggle_timer = timer_create(FramesRemaining,0);		
		aim_toggle = 0
	};
		
}; //function end bracket

