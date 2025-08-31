//var MyRange = point_distance(x,y,origin_x,origin_y);
//if(MyRange >= range) {instance_destroy(self)};

if(!IsBeam) {VisualCulling()};

//-------------------------------------------- barrier collision -----------------------------------------

var _XX = x+lengthdir_x(base_speed*2,direction);
var _YY = y+lengthdir_y(base_speed*2,direction);
var col_barrier = collision_line(x,y,_XX,_YY,o_barrier,true,1);

if(col_barrier and !Flames){
	
	//if(y < col_barrier)
	
	var kill_barrier = 0;
	var chance = irandom_range(0,100);
	var list = col_barrier.col_list;
	var collided = ds_list_find_index(list,id)
	
	if(chance <= col_barrier.chance and !collided){
		var facing = sign(col_barrier.image_xscale);
		var dist = distance_to_object(col_barrier)+random_range(10,60);
	
		if(facing = 1 and origin_x > col_barrier.bbox_right) {var kill_barrier = 1};
		if(facing =-1 and origin_x < col_barrier.bbox_left) {var kill_barrier = 1};
	
		if(kill_barrier){
			
		depth = -999;
		x=x+lengthdir_x(dist,direction);
		y=y+lengthdir_y(dist,direction);
		impact_wall = 1;
		//kill = 1;
		instance_destroy(self);		
		//kill_sound = col_barrier.sound[irandom_range(0,3)]
		};
	};
		
	if(chance > col_barrier.chance){
		if(ds_list_find_index(list,id)=-1) {ds_list_add(list,id)};
	};
};

//-------------------------------------- Collision Code --------------------------------------------------

var col_list = ds_list_create();

if(!IsBeam && !Flames){
	
	var _XX = x+lengthdir_x(base_speed,direction);
	var _YY = y+lengthdir_y(base_speed,direction);
	var _XXA = x+lengthdir_x(base_speed*1.2,direction);
	var _YYA = y+lengthdir_y(base_speed*1.2,direction);
	var col_actor = collision_line_list(x,y,_XXA,_YYA,o_actorParent,1,1,col_list,true);
	var Trigger = 0;
	
	if(col_actor > 0){		
		var i = 0;
		var Actor;
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
			//freeze = 1;
			var Line_Length2 = 0;
			var Collided2 = place_meeting(x,y,Actor);
			while(!Collided2 and (Line_Length2 < base_speed*3)) {
				Line_Length2 += 2;		
				x = x+lengthdir_x(Line_Length2,direction);
				y = y+lengthdir_y(Line_Length2,direction);
				Collided2 = place_meeting(x,y,Actor);
			};
			Trigger = 0;
		};
	};
	
	if((hp <= fuse) and !Flames) {instance_destroy(self)};
	
	if(collision_line(x,y,_XX,_YY,o_platform,0,1)){	
		//speed = 0;
		var Line_Length1 = 0;
		var Collided1 = place_meeting(x,y,o_platform);
		while(!Collided1 and (Line_Length1 < base_speed)) {
			Line_Length1 += 2;		
			x = x+lengthdir_x(Line_Length1,direction);
			y = y+lengthdir_y(Line_Length1,direction);
			Collided1 = place_meeting(x,y,o_platform);
		};
		if(Line_Length1 < base_speed) {
			impact_wall = 1;
			//kill = 1;
			instance_destroy(self);
		};
	};	
};

//---------------------------------------- special projectile code -------------------------------------

if(IsBeam && beamToggle) {

	var max_length = 4000;
	
	while(!endBeam && (beamLength < max_length) ){
		
		var lx = x + lengthdir_x(beamLength, direction);
		var ly = y + lengthdir_y(beamLength, direction);
		var lxa = x + lengthdir_x(beamLength-0, direction);
		var lya = y + lengthdir_y(beamLength-0, direction);
		
		if(collision_point(lx, ly, o_platform, false, true)) {
			impact_wall = 1;
			kill = 1; //trigger death after step event to allow beam a frame to actually exist
			break;	
		};		
		
		beamLength+=12;
		
	//----------------------------------------- BEAM BARRIER COLLISIONS -----------------------------------------
				
		col_barrier = collision_point(lx, ly, o_barrier, false, true);
		
		if(col_barrier) {
	
			var kill_barrier = 0;
			var chance = irandom_range(0,100);
			var list = col_barrier.col_list;
			var collided = ds_list_find_index(list,id)
	
			if(chance <= col_barrier.chance and !collided){
				var facing = sign(col_barrier.image_xscale);
				var dist = distance_to_object(col_barrier)+random_range(-15,50);
	
				if(facing = 1 and (x > col_barrier.bbox_right)) {kill_barrier = 1};
				if(facing = -1 and (x < col_barrier.bbox_left)) {kill_barrier = 1};
	
				if(kill_barrier){
					impact_wall = 1;
					beamLength += (random_range(0,50));
					depth = -999;
					damage = 0;
					hp = 0;
					MainBreak = 1;
				//kill_sound = col_barrier.sound[irandom_range(0,3)]	
				};
			};
		
		if(chance > col_barrier.chance){
			if(ds_list_find_index(list,id)=-1) {ds_list_add(list,id)};
		};
	};	
		
	//------------------------------------------ BEAM ACTOR COLLISIONS ------------------------------------------	
		/*
		var ActorCollision = collision_point_list(lx,ly,o_actorParent,false,true,col_list,true);
		var ActorCounter = 0;
		while (ActorCounter < ActorCollision) {
			var Actor = ds_list_find_value(col_list,ActorCounter);		
			if(instance_exists(Actor)){
				//if( (Actor.IFF != IFF) && (Actor.death[0] = 0) && (ds_list_find_index(Actor.collisions_list,id) = -1) ) {
				if( (Actor.IFF != IFF) and (Actor.death[0] = 0) ) {
					MainBreak = 1;
				};
			};
			ActorCounter+=1;
		};
		*/
		
		var ActorCollision = collision_point(lx,ly,o_actorParent,false,true);
		if(ActorCollision) {
			if(ActorCollision.IFF != IFF and !ActorCollision.death[0]){
				MainBreak=1;
			};
		};
		
		//if(hp <= 0) {MainBreak = 1};
		if(MainBreak) {endBeam = 1; beamToggle = 0; kill = 1; break};		
		
	}; //beam length check end
}; //isbeam check

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

//------------------------------------------------------- maintenance ---------------------------------------------------


//x+=hspd; y+=vspd;

if(!freeze) {speed = base_speed};
ds_list_destroy(col_list);

if(hp <= 0) {kill = 1};