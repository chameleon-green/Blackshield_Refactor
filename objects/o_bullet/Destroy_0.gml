/*
var xx = x;
var xx = y;
var IsBeam = string_count("beam",type.guidance); 

if(IsBeam) {
	var i = image_xscale*64;
	xx = x + lengthdir_x(i, direction);
	yy = y + lengthdir_y(i, direction);
}
*/
if(impact_type[0] = "explosion") {
	
	with(instance_create_depth(x,y,depth,o_explosion_scalable)) {
		explosion_type = other.impact_type;
		};
}

else if(impact_type[0] = "dust"){
	with(instance_create_depth(x,y,depth-1,oprt_smoke)) {
		image_blend = other.impact_type[3];
		direction = other.direction + 180;
		speed = random_range(4,7)
		mass = other.impact_type[1]; 
		max_scale = other.impact_type[2];
		};
};

if(time_source_exists(kill_timer)) {time_source_destroy(kill_timer)};

with(o_actorParent) {
	var Index = ds_list_find_index(collisions_list,other.id);
	if(Index != -1) {ds_list_delete(collisions_list,Index)};
};