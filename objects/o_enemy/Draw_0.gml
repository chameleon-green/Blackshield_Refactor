
draw_self();
/*
draw_text(x,bbox_top,hp_body_head);


draw_text(x,bbox_top-12,skeleton_animation_get_frames(weapon_ranged.animation_group.fire));

draw_rectangle(x-hbox_torso[0],y-hbox_torso[1],x-hbox_torso[2],y-hbox_torso[3],true);
draw_rectangle(x-hbox_legs[0],y-hbox_legs[1],x-hbox_legs[2],y-hbox_legs[3],true);
draw_rectangle(x-hbox_head[0],y-hbox_head[1],x-hbox_head[2],y-hbox_head[3],true);

draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true);

//if(instance_exists(TargetNode)) {draw_text(TargetNode.x,TargetNode.bbox_top,"NODE")};
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



