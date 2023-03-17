

if(!IsBeam) {VisualCulling()};

//-------------------------------------- Collision Code --------------------------------------------------

x+=hspd; y+=vspd;


if(!IsBeam && !Flames){
var _XX = x+lengthdir_x(base_speed,direction);
var _YY = y+lengthdir_y(base_speed,direction);

if(collision_line(x,y,_XX,_YY,o_platform,0,1)){	
	speed = 0;
	var Line_Length = 0;
	var Collided = place_meeting(x,y,o_platform);
	while(!Collided and (Line_Length < base_speed)) {
		Line_Length += 1;		
		x = x+lengthdir_x(Line_Length,direction);
		y = y+lengthdir_y(Line_Length,direction);
		var Collided = place_meeting(x,y,o_platform);
	};
	if(Line_Length < base_speed) {instance_destroy(self)};
	speed = base_speed;
};
};
//---------------------------------------- special projectile code -------------------------------------

if(Flames) {
	if(image_index >= flameframes) {instance_destroy(self)};
	if(image_index/flameframes > 0.7) {lethal = 0 hp = 0};

	gravity_direction = 270;
	gravity = -0.04 * cycle_speed;
	
	image_yscale = clamp(image_yscale*(1 + 0.05*cycle_speed),0,9); //set to 1.5 for fun 0.03
	image_xscale = (image_xscale * (1 + 0.01*cycle_speed) )*1; //set to 1.5 for fun 0.005
	image_alpha = image_alpha * (1 - 0.05*cycle_speed);
};	

//------------------------------------------------------------------------------------------------------
if(IsBeam) {
	
	var max_length = 6000;
	
	while(!endBeam && (beamLength < max_length) ){
	
		beamLength+=15;
		var lx = x + lengthdir_x(beamLength, direction);
		var ly = y + lengthdir_y(beamLength, direction);
		var lxa = x + lengthdir_x(beamLength-45, direction);
		var lya = y + lengthdir_y(beamLength-45, direction);
		
		if(collision_point(lx, ly, o_platform, false, true)) {
			kill = 1; //trigger death after step event to allow beam a frame to actually exist
			break;	
		};		
		
		//-----------------------------------------------------------------------------------------------------
		var ActorList = ds_list_create();
		var ActorCollision = collision_line_list(x,y,lxa,lya,o_actorParent,0,true,ActorList,true);
		var ActorCounter = 0;
		var MainBreak = 0;
		while (ActorCounter<ActorCollision) {
			var Actor = ds_list_find_value(ActorList,ActorCounter);		
			if(instance_exists(Actor)){
				if( (Actor.IFF != IFF) && (ds_list_find_index(Actor.collisions_list,id) = -1) ) {MainBreak = 1};
				};
			ActorCounter+=1;
		};
		ds_list_destroy(ActorList);
		if(MainBreak) {break};
		//------------------------------------------------------------------------------------------------------
	};
};

if(beamLength >= 6000) {kill = 1};
if(hp <= 0) {instance_destroy(self)};
/*


/*
		//-----------------------------------------------------------------------------------------------------
		var ActorList = ds_list_create();
		var ActorCollision = collision_line_list(x,y,lxa,lya,o_actorParent,0,true,ActorList,true);
		var ActorCounter = 0;
		while (ActorCounter<ActorCollision) {
			var Actor = ds_list_find_value(ActorList,ActorCounter);		
			if(instance_exists(Actor)){
				if( (Actor.IFF != creator.IFF) && (ds_list_find_index(Actor.collisions_list,id) != -1) ) {BreakMain = 1; break};
				};
			ActorCounter+=1;
		};
		ds_list_destroy(ActorList);
		//------------------------------------------------------------------------------------------------------