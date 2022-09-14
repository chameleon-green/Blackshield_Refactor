var AngOffset = -90;
if(abs(creator.swing[2]) > 90) {var AngOffset = 90};

x = creator.swing[0];
y = creator.swing[1];
image_angle = creator.swing[2] + AngOffset;


//var LineCol = collision_line(x,y,x+lengthdir_x(80,image_angle),y+lengthdir_y(80,image_angle),o_platform,1,false);
var MaskCol = place_meeting(x,y,o_platform);

if(MaskCol) {	
	if(sound_toggle) {
		sound_toggle = 0; 
		var snd = audio_play_sound(snd_impact_melee1,1,0); 
		audio_sound_pitch(snd,random_range(0.95,1.05));
		instance_create_depth(x,y,depth-1,o_explosion);
	}	
	
	//instance_destroy(self);	
};


if(!creator.swinging or !creator.swing[3]) {instance_destroy(self)};


