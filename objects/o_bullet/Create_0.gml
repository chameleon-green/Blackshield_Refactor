sprite_index = type.projectile_type[0];

if(sprite_index = sp_bullet) {image_speed = 0};
image_blend = type.projectile_color[0];

damage_type = type.damage_type;
penetration = damage*type.armor_penetration;
hp = damage;
fuse = hp*type.fuse;

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
	