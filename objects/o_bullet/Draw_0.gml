
var cam = view_camera[0];
var x1 = camera_get_view_x(cam);
var y1 = camera_get_view_y(cam);
var x2 = x1 + camera_get_view_width(cam);
var y2 = y1 + camera_get_view_height(cam);
if( !point_in_rectangle( x, y, x1, y1, x2, y2)) {visible = 0;}


image_angle = direction;
draw_self();
draw_sprite_ext(sp_bullet,1,x,y,1,1,direction,type.projectile_color[1],1);
//draw_text(x,y-10,IFF);