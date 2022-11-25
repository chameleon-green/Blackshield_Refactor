
/*
if(image_angle != 0) {
draw_sprite_ext(sprite_index,0,x-40,y,image_xscale,image_yscale,image_angle,c_white,1)
};

else{draw_self()};


draw_self();



draw_rectangle(bbox_left,YCoord[0],bbox_left-40,YCoord[0]-(32*abs(image_yscale)),1);
draw_rectangle(bbox_right,YCoord[1],bbox_right+40,YCoord[1]-(32*abs(image_yscale)),1);
*/


draw_self();


draw_text(x,y+20,id);

/*
var YCoord = [0,0,0];
if(image_angle < 0) {YCoord = [bbox_top,bbox_bottom,-1,-1]} 
if(image_angle = 0) {YCoord = [bbox_bottom,bbox_bottom,1,-1]};
if(image_angle > 0) {YCoord = [bbox_bottom,bbox_top,1,1]};
var Thickness = 32*image_yscale;

draw_circle(bbox_left,YCoord[0]-(YCoord[2]*Thickness/2),Thickness*0.75,1);
draw_circle(bbox_right,YCoord[1]+(YCoord[3]*Thickness/2),Thickness*0.75,1);

