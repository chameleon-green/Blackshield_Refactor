

draw_self();



//--------------------------------------------- DEBUG STUFF ------------------------------------------------
draw_text(x,bbox_top,reloading);

//ds_list_draw(collisions_list,x,bbox_top);

//draw_text(x,bbox_top,o_IC.AIQ);
/*
ds_list_draw(AIQueue,x,bbox_top);

draw_rectangle(x-hbox_torso[0],y-hbox_torso[1],x-hbox_torso[2],y-hbox_torso[3],true);
draw_rectangle(x-hbox_legs[0],y-hbox_legs[1],x-hbox_legs[2],y-hbox_legs[3],true);
draw_rectangle(x-hbox_head[0],y-hbox_head[1],x-hbox_head[2],y-hbox_head[3],true);
 
draw_set_halign(fa_center);

draw_text(x,bbox_top-90,"head:"+string(hp_body_head)+"/"+string(hp_body_head_max));
draw_text(x,bbox_top-60,"torso:"+string(hp_body_torso)+"/"+string(hp_body_torso_max));
draw_text(x-110,y-100,"armL:"+string(hp_body_armL)+"/"+string(hp_body_armL_max));
draw_text(x+110,y-100,"armR:"+string(hp_body_armR)+"/"+string(hp_body_armR_max));
draw_text(x-90,y-50,"legL:"+string(hp_body_legL)+"/"+string(hp_body_legL_max));
draw_text(x+90,y-50,"legR:"+string(hp_body_legR)+"/"+string(hp_body_legR_max));


draw_text(x,bbox_top-170,armor_head[4]);
draw_text(x,bbox_top-160,armor_torso[4]);
draw_text(x,bbox_top-150,armor_armL[4]);
draw_text(x,bbox_top-140,armor_armR[4]);
draw_text(x,bbox_top-130,armor_legL[4]);
draw_text(x,bbox_top-120,armor_legR[4]);

Angle_Timer[0] += 1;
if(Angle_Timer[0] > Angle_Timer[1]) {Angle_Timer[0] = 0};

