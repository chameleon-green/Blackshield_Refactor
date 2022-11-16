draw_self();

StepScript();
AStarMovement(1,1);

draw_text(x,bbox_top-45,"Start Node:" + string(StartNode));
draw_text(x,bbox_top-30,"Target Node:" + string(TargetNode));

ds_list_draw(PathList,x-100,bbox_top);