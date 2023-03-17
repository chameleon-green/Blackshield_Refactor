
//Disables draw event for objects that are not within the player's view
//MiddleCheck can be enabled for large objects that can potentially span the entire view, with their corners outside of the view area
function VisualCulling(MiddleCheck=1){
	
	visible = 1;
	
	var cam = view_camera[0];
	var x1 = camera_get_view_x(cam);
	var y1 = camera_get_view_y(cam);
	var x2 = x1 + camera_get_view_width(cam);
	var y2 = y1 + camera_get_view_height(cam);
	var MiddleX = bbox_left + ( abs(bbox_left-bbox_right)/2 );
		
	var UpperLeftInView = point_in_rectangle(bbox_left,bbox_top,x1,y1,x2,y2);
	var UpperRightInView = point_in_rectangle(bbox_right,bbox_top,x1,y1,x2,y2);
	var UpperMiddleInView = 0;
	
	var LowerLeftInView = point_in_rectangle(bbox_left,bbox_bottom,x1,y1,x2,y2);
	var LowerRightInView = point_in_rectangle(bbox_right,bbox_bottom,x1,y1,x2,y2);
	var LowerMiddleInView = 0;
	
	if(MiddleCheck) {
		UpperMiddleInView = point_in_rectangle(MiddleX,bbox_top,x1,y1,x2,y2);
		LowerMiddleInView = point_in_rectangle(MiddleX,bbox_bottom,x1,y1,x2,y2);
	};

	if(!UpperLeftInView && !UpperRightInView && !LowerLeftInView && !LowerRightInView && !UpperMiddleInView && !LowerMiddleInView) {visible = 0};

};