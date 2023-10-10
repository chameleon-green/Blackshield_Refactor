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

instance_create_depth(x,y,depth-1,o_explosion_scalable);

if(time_source_exists(kill_timer)) {time_source_destroy(kill_timer)};

with(o_actorParent) {
	var Index = ds_list_find_index(collisions_list,other.id);
	if(Index != -1) {ds_list_delete(collisions_list,Index)};
};