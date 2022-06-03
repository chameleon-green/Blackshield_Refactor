visible = 1;

if(kill_toggle) {
	kill_toggle = 0;
	alarm[0] = kill
};


if(abs(hspd) > 0) {
	
var col_bot = place_meeting(x,y+vspd,o_platform);
var col_side = place_meeting(x+(hspd*2),y,o_platform);

x += hspd;
y += vspd;
angle += angspeed;

if(vspd < 32 && !col_bot) {vspd += 1};


if(col_bot) {
	vspd = -vspd*0.33;
	angspeed = angspeed*0.5;
	hspd = hspd*0.6;
	move_outside_solid(90,-1)
};

if(col_side) {
	var Facing = sign(hspd);
	move_outside_solid(clamp(180*Facing,0,180),-1);
	hspd = -hspd*0.8;
	angspeed = angspeed*0.5	
};


if(col_bot && abs(hspd) < 1) {hspd = 0};
if(abs(hspd) = 0 && col_bot && abs(vspd) < 1) {vspd = 0};

}; //hspd check