 
if(hp <= 0) {instance_destroy(self)};

var xx = x+lengthdir_x(hspeed,direction);
var yy = y+lengthdir_y(vspeed,direction);
var colv = collision_line(x,y,x,yy,o_platform,true,0);
var colh = collision_line(x,y,xx,y,o_platform,true,0);





if(colv) {
	vspeed = -vspeed*random_range(0.6,0.9)
};

if(colh) {
	hspeed = -hspeed*random_range(0.5,0.8)
};

/*
if(speed < 3) {
	instance_destroy()
};
*/
image_angle = direction;
