// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function VisualCulling(x,y){
	
	visible = 1;
	var cam = view_camera[0];
	var x1 = camera_get_view_x(cam);
	var y1 = camera_get_view_y(cam);
	var x2 = x1 + camera_get_view_width(cam);
	var y2 = y1 + camera_get_view_height(cam);
	draw_rectangle(x1+10,y1-10,x2-10,y2+10,1);
	var UpperLeftInView = point_in_rectangle(bbox_left,bbox_top,x1,y1,x2,y2);
	var UpperRightInView = point_in_rectangle(bbox_right,bbox_top,x1,y1,x2,y2);
	var LowerLeftInView = point_in_rectangle(bbox_left,bbox_bottom,x1,y1,x2,y2);
	var LowerRightInView = point_in_rectangle(bbox_right,bbox_bottom,x1,y1,x2,y2);
	
	if(!UpperLeftInView && !UpperRightInView && !LowerLeftInView && !LowerRightInView) {visible = 0};
};