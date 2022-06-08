visible = 1;



if(Flames) {
	if(image_index >= flameframes) {instance_destroy(self)};
	if(image_index/flameframes > 0.7) {lethal = 0 hp = 0};

	gravity_direction = 270;
	gravity = -0.04 * cycle_speed;
	
	image_yscale = clamp(image_yscale*(1 + 0.05*cycle_speed),0,9); //set to 1.5 for fun 0.03
	image_xscale = (image_xscale * (1 + 0.01*cycle_speed) )*1; //set to 1.5 for fun 0.005
	image_alpha = image_alpha * (1 - 0.05*cycle_speed);
};	



