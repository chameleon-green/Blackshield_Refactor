direction = irandom_range(180, -180); 
alarm[0] = 1000//life

flames = 0;
base_speed = 30//30;
IFF = "none"; //frag cares not for your allegiences
penetration = 0;

IsBeam = 0;

gravity = 0;
gravity_direction = 270;
speed = 6;
alarm[1] = 5;
//dumb solution to a collision issue, makes frags spawn in slomo to handle initial 
//richochets before accelerating them
speedkill = 0;
alarm[2] = 10; //speed kill alarm, see last comment

impact_sound = 1;

oX = x;
oY = y;

if(place_meeting(x,y,o_platform)) {
	move_outside_solid(final_dir+180,100);
};