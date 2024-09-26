sprite_index = type.projectile_type[0];

if(sprite_index = sp_bullet) {image_speed = 0};
image_blend = type.projectile_color[0];
depth = -101;
image_speed = 0;
light_enable = -1;

damage_type = type.damage_type[0];
penetration = damage*type.armor_penetration;
hp = damage;
fuse = hp*type.fuse;

base_speed = speed;

kill = 0;
endBeam = 0;
beamLength = 0;
beamToggle = 1;

KillMe = function(){
	instance_destroy(self)
};

kill_timer = time_source_create(time_source_game,2,time_source_units_frames,KillMe);

IsBeam = 0; Flames = 0;
//-------------------------------------------------------------------------------------
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
speed = base_speed;
ds_list_destroy(col_list);
//------------------------------------------ Special projectile code ------------------------------------	

Flames = (string_count("flames",sprite_get_name(sprite_index)));
if(Flames){

	flameframes =  (sprite_get_number(sprite_index) - 0);
	
	cycle_speed = 1;
	sprite_set_speed(sprite_index,flameframes*cycle_speed,spritespeed_framespersecond);
	speed = 24;

	impact_sound = 0;
	lethal = 1;

	image_xscale = clamp(5*cycle_speed,4,99);               
	image_yscale = clamp(1.5*cycle_speed,1,99);
	image_alpha = 1;
	image_speed = 1;
};
	
	
IsBeam = string_count("beam",type.guidance);
