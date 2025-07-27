
draw_self();

if(instance_exists(TargetNode)) {draw_text(TargetNode.x,TargetNode.bbox_top,"NODE")};
/*
draw_text(x,bbox_top,string(HP) + "/" + string(max_hp));
draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,1);
//draw_text(x,bbox_top,point_distance(x,y,MyTarget.x,MyTarget.y));
//draw_text(x,bbox_top,beamLength);
//draw_text(x,bbox_top,ClearToProcess);
/*
draw_text(x,bbox_top-145,"Start Node:" + string(StartNode));
draw_text(x,bbox_top-130,"Target Node:" + string(TargetNode));

ds_list_draw(PathList,x,bbox_top-155);

