

if(!IsBeam) {VisualCulling()};

//-------------------------------------- Collision Code --------------------------------------------------

if(hp <= 0) {instance_destroy(self)};
x+=hspd; y+=vspd;
speed = base_speed;
var col_list = ds_list_create();

if(!IsBeam && !Flames){
	
	var _XX = x+lengthdir_x(base_speed,direction);
	var _YY = y+lengthdir_y(base_speed,direction);
	var _XXA = x+lengthdir_x(base_speed*3,direction);
	var _YYA = y+lengthdir_y(base_speed*3,direction);
	var col_actor = collision_line_list(x,y,_XXA,_YYA,o_actorParent,0,1,col_list,1);

	if(col_actor > 0){		
		var i = 0;
		var Actor = -1;
		var Trigger = 0;
		while(i<col_actor) {
			Actor = col_list[| i];
			if(instance_exists(Actor)) {
				var ActorColList = Actor.collisions_list;
				if((Actor.death[0] = 0) && (ds_list_find_index(ActorColList,id)=-1)) {Trigger=1 break};
			};
			i++;
		};
		
		if(Trigger) {
			speed = 0;
			var Line_Length2 = 0;
			var Collided2 = place_meeting(x,y,Actor);
			while(!Collided2 and (Line_Length2 < base_speed*3.1)) {
				Line_Length2 += 2;		
				x = x+lengthdir_x(Line_Length2-10,direction);
				y = y+lengthdir_y(Line_Length2-10,direction);
				var Collided2 = place_meeting(x,y,Actor);
			};	
		};
	};
	
	if(collision_line(x,y,_XX,_YY,o_platform,0,1)){	
		//speed = 0;
		var Line_Length1 = 0;
		var Collided1 = place_meeting(x,y,o_platform);
		while(!Collided1 and (Line_Length1 < base_speed)) {
			Line_Length1 += 2;		
			x = x+lengthdir_x(Line_Length1,direction);
			y = y+lengthdir_y(Line_Length1,direction);
			var Collided1 = place_meeting(x,y,o_platform);
		};
		if(Line_Length1 < base_speed) {instance_destroy(self)};
	};
	
};


//---------------------------------------- special projectile code -------------------------------------

if(IsBeam && beamToggle) {
	
	var max_length = 4000;
	var Beam_Mod = 200; //beam length increase per tick, modified when detecting something
	
	while(!endBeam && (beamLength < max_length) ){
		
		var lx = x + lengthdir_x(beamLength, direction);
		var ly = y + lengthdir_y(beamLength, direction);
		var lxa = x + lengthdir_x(beamLength-10, direction);
		var lya = y + lengthdir_y(beamLength-10, direction);
		
		if(collision_point(lx, ly, o_platform, false, true)) {
			kill = 1; //trigger death after step event to allow beam a frame to actually exist
			break;	
		};		
		
		beamLength+=12;
		
		//-----------------------------------------------------------------------------------------------------	
		var ActorCollision = collision_line_list(x,y,lxa,lya,o_actorParent,0,true,col_list,true);
		var ActorCounter = 0;
		var MainBreak = 0;
		while (ActorCounter<ActorCollision) {
			var Actor = ds_list_find_value(col_list,ActorCounter);		
			if(instance_exists(Actor)){
				if( (Actor.IFF != IFF) && (Actor.death[0] = 0) && (ds_list_find_index(Actor.collisions_list,id) = -1) ) {MainBreak = 1};
				};
			ActorCounter+=1;
		};
		
		if(MainBreak) {beamToggle = 0; kill = 1; break};
		//------------------------------------------------------------------------------------------------------
		
		
	};
};

if(beamLength >= 4000) {kill = 1};


if(Flames) {
	if(image_index >= flameframes) {instance_destroy(self)};
	if(image_index/flameframes > 0.7) {lethal = 0 hp = 0};

	gravity_direction = 270;
	gravity = -0.04 * cycle_speed;
	
	image_yscale = clamp(image_yscale*(1 + 0.05*cycle_speed),0,9); //set to 1.5 for fun 0.03
	image_xscale = (image_xscale * (1 + 0.01*cycle_speed) )*1; //set to 1.5 for fun 0.005
	image_alpha = image_alpha * (1 - 0.05*cycle_speed);
};	


ds_list_destroy(col_list);
