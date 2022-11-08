if(place_meeting(x,y,o_navnode)) {
	instance_destroy(other);
};

if(place_meeting(x,y,o_platform)) {
	instance_destroy(self);
};