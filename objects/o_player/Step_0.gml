
CanShoot = 1;

PlayerMovement();

if(sprinting or rolling) {CanShoot = 0};

if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};

/*
var cam = view_camera[0];
var x1 = camera_get_view_x(cam);
var y1 = camera_get_view_y(cam);
var x2 = x1 + camera_get_view_width(cam);
var y2 = y1 + camera_get_view_height(cam);
if( !point_in_rectangle( x, y, x1, y1, x2, y2)) {visible = 0;}

