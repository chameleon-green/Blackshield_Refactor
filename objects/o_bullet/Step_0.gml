VisualCulling();

//-------------------------------------- Collision Code --------------------------------------------------

//x+=hspd; y+=vspd;

var _XX = x+lengthdir_x(base_speed,direction);
var _YY = y+lengthdir_y(base_speed,direction);

if(collision_line(x,y,_XX,_YY,o_platform,0,1)){	
	speed = 0;
	var Line_Length = 0;
	var Collided = place_meeting(x,y,o_platform);
	while(!Collided and (Line_Length < base_speed)) {
		Line_Length += 1;		
		x = x+lengthdir_x(Line_Length,direction);
		y = y+lengthdir_y(Line_Length,direction);
		var Collided = place_meeting(x,y,o_platform);
	};
	if(Line_Length < base_speed) {instance_destroy(self)};
	speed = base_speed;
};

//---------------------------------------- special projectile code -------------------------------------

if(Flames) {
	if(image_index >= flameframes) {instance_destroy(self)};
	if(image_index/flameframes > 0.7) {lethal = 0 hp = 0};

	gravity_direction = 270;
	gravity = -0.04 * cycle_speed;
	
	image_yscale = clamp(image_yscale*(1 + 0.05*cycle_speed),0,9); //set to 1.5 for fun 0.03
	image_xscale = (image_xscale * (1 + 0.01*cycle_speed) )*1; //set to 1.5 for fun 0.005
	image_alpha = image_alpha * (1 - 0.05*cycle_speed);
};	

var IsBeam = string_count("beam",type.guidance); 

if(IsBeam) {
	var max_length = 6000;

	for(var i = 0; i < max_length; i+=6){

	var lx = x + lengthdir_x(i, direction);
	var ly = y + lengthdir_y(i, direction);
	
	var Image = type.projectile_type;
		
	var SpriteArray = sprite_get_uvs(Image[0],Image[1]);
	var TexW = 1/texture_get_texel_width(sprite_get_texture(Image[0],Image[1]));
	
	var XscaleFactor = abs(SpriteArray[0] - SpriteArray[2])*TexW;
	var YscaleFactor = type.projectile_type[2]
		
	image_xscale = i/XscaleFactor;
	image_yscale = YscaleFactor;
	
	if(collision_point(lx, ly, o_platform, false, true)) {
		kill = 1
		break;	
	}
	
	}
x+=hspd; y+=vspd;
kill = 1;
};