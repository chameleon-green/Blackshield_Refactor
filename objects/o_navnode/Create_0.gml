cover = 0;
depth = -999;
image_speed = 0;

if(place_meeting(x,y,o_navnode)) {
	instance_destroy(other);
};

if(place_meeting(x,y,o_platform)) {
	instance_destroy(self);
};

if(place_meeting(x,y,o_cover)) {
	cover = 1;
	image_index = 1;
};