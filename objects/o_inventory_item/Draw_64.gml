if( !is_struct(item) ) {instance_destroy(self)}; //crashproofing

image_index = 1
scale = creator.scale;
image_xscale = scale;
image_yscale = scale;

Mouse_X = creator.Mouse_X;
Mouse_Y = creator.Mouse_Y;
var Ycent = window_get_height()/2; var Xcent = window_get_width()/2
var Click = mouse_check_button_pressed(mb_left);

var Color = c_dkgray;

x = Xcent-(132*scale); y = Ycent - (133*scale) + (yoffset*36*scale);

//------------------------------------------ Mouse interactions ----------------------------------------

var touching = point_in_rectangle(Mouse_X,Mouse_Y,bbox_left,bbox_top,bbox_right,bbox_bottom);
if( touching or (global.Selected = id) ) {image_index = 0; Color = c_yellow};
if(Click && touching) {global.Selected = id};

//----------------------------------------- Drawing Stuff -------------------------------------------------

draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_text_ext_transformed_color(x,y+(6*scale),item.name,1,99999,scale*0.8,scale*0.9,0,Color,Color,Color,Color,1);
draw_text_ext_transformed_color(x,y+(20*scale),unique_id,1,99999,scale*0.8,scale*0.9,0,Color,Color,Color,Color,1);