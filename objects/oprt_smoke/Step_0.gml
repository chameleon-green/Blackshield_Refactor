if(firey = 1) {
	aspeed = 0;
	sprite_index = spr_flames_dirty;
	var frame_count = sprite_get_number(spr_flames_dirty);
	if(image_index < 5) {image_index = 5};
	if(image_index >= frame_count-1) {image_speed = 0}
	else{image_speed = 1.1};
};


var mass_factor = 0.80+(mass/100);
var speed_factor = clamp(mass_factor,0,0.95);
if(max_speed > 0) {speed = clamp(speed*speed_factor,0.1,90)} else{speed = 0};
aspeed = aspeed*0.995;
image_angle += aspeed;

if(max_speed > 0) {scale = max_scale*(1 - speed/max_speed)} else{scale = max_scale};
image_xscale = scale + scale*firey;
image_yscale = scale + scale*firey;

var white = (image_blend = c_white);

var lifetime_unclamped = (mass*mass*mass)/(5-white) + ((mass*mass*mass)/(5-white))*!max_speed;
lifetime = clamp(lifetime_unclamped/(1+5*firey),10,4500);
life_timer += 1;
var A = life_timer/lifetime;
image_alpha = 0.9-A;
if(life_timer >= lifetime) {instance_destroy(self)};


