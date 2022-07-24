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

if( (creator.SubTab != MySubTab) or (creator.Tab != MyTab) or !creator.visible) {instance_destroy(self)};

//------------------------------------------ Coordinate Stuff -------------------------------------------------

var BaseY = Ycent - (133*scale) + (yoffset*36*scale);
x = Xcent-(132*scale);  
y =  BaseY - (scrollbar.Offset + (120*scale) )*scrollbar.DisplacementMod + scrollbar.item_count/4*scale

//------------------------------------------ Mouse interactions ----------------------------------------

var touching = point_in_rectangle(Mouse_X,Mouse_Y,bbox_left,bbox_top,bbox_right,bbox_bottom);
if( (touching && Interactable) or (global.Selected = id) ) {image_index = 0; Color = c_yellow};
if(Click && touching && Interactable) {global.Selected = id};

//----------------------------------------- Drawing Stuff -------------------------------------------------

draw_set_halign(fa_center);
draw_set_valign(fa_center);

var MyDisplacement = (Ycent - y)/scale;
var GridYValue = ds_grid_value_y(grid,0,0,ds_grid_width(grid)-1,creator.InventorySize-1,unique_id);
var Quantity = ds_grid_get(grid,1,GridYValue);
var TitleText = item.name;

var IsAmmo = variable_struct_exists(item,"projectile_type");

if(IsAmmo) {TitleText = item.name + " (" + string(Quantity) + ")"};

if ( (MyDisplacement >= -158) and (MyDisplacement <= 135) ){
	
	Interactable = 1;
	
	draw_self();	
	draw_text_ext_transformed_color(x,y+(7*scale),TitleText,1,99999,scale*0.8,scale*0.9,0,Color,Color,Color,Color,1);

};

//bottom cutoff
if ( (MyDisplacement < -158) and (MyDisplacement > -192) ){
	
	Interactable = 0;
	
	var BottomBound = Ycent + (188*scale);
	var Difference = (y+(36*scale)) - BottomBound;
	var Height = 36-(Difference/scale);
	draw_sprite_general(sprite_index,image_index,0,0,313,Height,bbox_left,y,scale,scale,0,c_white,c_white,c_gray,c_gray,1)
	
	if( abs(Height) > 23 ) {
		draw_text_ext_transformed_color(x,y+(7*scale),TitleText,1,99999,scale*0.8,scale*0.9,0,Color,Color,Color,Color,1)
		Interactable = 1;
	};
	
};

//top cutoff
if ( (MyDisplacement > 135) and (MyDisplacement < 166) ){
	
	Interactable = 0;
	
	var TopBound = Ycent - (135*scale);
	var Difference = TopBound - y;
	var Height = 36-(Difference/scale);
	draw_sprite_general(sprite_index,image_index,0,36,313,-Height,bbox_left,y+(36*scale),scale,scale,0,c_white,c_white,c_gray,c_gray,1)
	
	if( abs(Height) > 26 ) {
		draw_text_ext_transformed_color(x,y+(7*scale),TitleText,1,99999,scale*0.8,scale*0.9,0,Color,Color,Color,Color,1)
		Interactable = 1;
	};
};


