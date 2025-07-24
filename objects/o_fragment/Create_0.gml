direction = irandom_range(0, 360); 
//if(direction = 90) {direction = 93};
//if(direction = -90) {direction = -93};

alarm[0] = life

flames = 0;
base_speed = 30//30;
IFF = "none"; //frag cares not for your allegiences
penetration = 0;

IsBeam = 0;

gravity = 0.5;
gravity_direction = 270;
speed = base_speed;//6;
//alarm[1] = 2;
//dumb solution to a collision issue, makes frags spawn in slomo to handle initial 
//richochets before accelerating them

impact_sound = 1;

oX = x;
oY = y;

if(place_meeting(x,y,o_platform)) {
	move_outside_solid(final_dir+180,1000);
};