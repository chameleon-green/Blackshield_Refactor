var XX = x;
var YY = y;
if(IsBeam) {
	XX = x + lengthdir_x(beamLength, direction);
	YY = y + lengthdir_y(beamLength, direction);
};

if(impact_type[0] = "explosion") {	
	with(instance_create_depth(XX,YY,depth,o_explosion_scalable)) {
		explosion_type = other.impact_type;
		damage = other.damage;
		damage_type = other.damage_type;
		final_dir = other.direction;
		};
}

else if(impact_type[0] = "dust"){
	if(impact_wall){ // XX & YY not necessary for beams here
	
		var RandMult = random_range(0.75,1.1);	
		with(instance_create_depth(XX,YY,depth-1,oprt_smoke)) {
			image_blend = other.impact_type[3];
			direction = other.direction + 180;
			speed = random_range(4,7)
			mass = other.impact_type[1]*RandMult; 
			max_scale = other.impact_type[2]*RandMult;
		};
	};
};

with(o_actorParent) {
	var Index = ds_list_find_index(collisions_list,other.id);
	if(Index != -1) {ds_list_delete(collisions_list,Index)};
};


MyGhost.StartKill = 1;