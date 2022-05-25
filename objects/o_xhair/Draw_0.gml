
x = mouse_x;
y = mouse_y;

image_xscale = 1;
image_yscale = 1;


var Owner_Distance = point_distance(x,y,owner.x,owner.y);
var Owner_Spread = degtorad(clamp(owner.spread_angle,0,89));


var HairOffset = clamp(tan(Owner_Spread)*Owner_Distance,6,130);
var HairScale = clamp(HairOffset/20,1,10);

draw_self();

draw_sprite_ext(sp_xhair,1,x,y-HairOffset,1,HairScale,0,c_white,1); //upper hair
draw_sprite_ext(sp_xhair,1,x,y+HairOffset,1,HairScale,180,c_white,1); //lower hair
draw_sprite_ext(sp_xhair,1,x+HairOffset,y,1,HairScale,-90,c_white,1); //right hair
draw_sprite_ext(sp_xhair,1,x-HairOffset,y,1,HairScale,90,c_white,1); //left hair
