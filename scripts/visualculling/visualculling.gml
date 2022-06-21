// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function VisualCulling(){
	
	var cam = view_camera[0];
	var x1 = camera_get_view_x(cam);
	var y1 = camera_get_view_y(cam);
	var x2 = x1 + camera_get_view_width(cam);
	var y2 = y1 + camera_get_view_height(cam);
	if( !point_in_rectangle( x, y, x1, y1, x2, y2)) {visible = 0;}
	
}