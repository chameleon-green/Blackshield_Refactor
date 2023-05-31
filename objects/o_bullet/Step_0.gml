

if(!IsBeam) {VisualCulling()};

//-------------------------------------- Collision Code --------------------------------------------------

if(hp <= 0) {instance_destroy(self)};
x+=hspd; y+=vspd;
speed = base_speed;

if(!IsBeam && !Flames){
	var _XX = x+lengthdir_x(base_speed,direction);
	var _YY = y+lengthdir_y(base_speed,direction);
	var _XXA = x+lengthdir_x(base_speed*5,direction);
	var _YYA = y+lengthdir_y(base_speed*5,direction);

	if(collision_line(x,y,_XX,_YY,o_platform,0,1)){	
		speed = 0;
		var Line_Length = 0;
		var Collided = place_meeting(x,y,o_platform);
		while(!Collided and (Line_Length < base_speed)) {
			Line_Length += 2;		
			x = x+lengthdir_x(Line_Length,direction);
			y = y+lengthdir_y(Line_Length,direction);
			var Collided = place_meeting(x,y,o_platform);
		};
		if(Line_Length < base_speed) {instance_destroy(self)};
	};
	
	if(collision_line(x,y,_XXA,_YYA,o_actorParent,0,1) && !place_meeting(x,y,o_actorParent)){	
		speed = 0;
		var Line_Length = 0;
		var Collided = place_meeting(x,y,o_actorParent);
		while(!Collided and (Line_Length < base_speed*5)) {
			Line_Length += 1;		
			x = x+lengthdir_x(Line_Length,direction);
			y = y+lengthdir_y(Line_Length,direction);
			var Collided = place_meeting(x,y,o_actorParent);
		};		
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
	var Beam_Mod = 200; //beam length increase per tick, modified when detecting something
	
	while(!endBeam && (beamLength < max_length) ){
		
		var lx = x + lengthdir_x(beamLength, direction);
		var ly = y + lengthdir_y(beamLength, direction);
		var lxa = x + lengthdir_x(beamLength-48, direction);
		var lya = y + lengthdir_y(beamLength-48, direction);
		
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
		
		beamLength+=16;
	};
};

if(beamLength >= 6000) {kill = 1};

