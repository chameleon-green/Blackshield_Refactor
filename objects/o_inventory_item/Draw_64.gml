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

var IsEquipped = ( (MyPlayer.wpn_primary_id = unique_id) or 
				   (MyPlayer.wpn_secondary_id = unique_id) or
				   (MyPlayer.wpn_melee_id = unique_id) or
				   (MyPlayer.ammo_primary_id = unique_id)
				 );

//------------------------------------------ Coordinate Stuff -------------------------------------------------

var BaseY = Ycent - (133*scale) + (yoffset*36*scale);
x = Xcent-(132*scale);  
y =  BaseY - (scrollbar.Offset + (120*scale) )*scrollbar.DisplacementMod + scrollbar.item_count/4*scale

//------------------------------------------ Mouse interactions ----------------------------------------

var Selected = (global.Selected[0] = unique_id);
var touching = point_in_rectangle(Mouse_X,Mouse_Y,bbox_left,bbox_top,bbox_right,bbox_bottom);
if( (touching && Interactable) or Selected or IsEquipped) {image_index = 0; Color = c_yellow};
if(Click && touching && Interactable) {global.Selected = [unique_id,item]};

//----------------------------------------- Drawing Stuff -------------------------------------------------

draw_set_font(fnt_caslonSB);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

var MyDisplacement = (Ycent - y)/scale;
var GridYValue = ds_grid_value_y(grid,0,0,ds_grid_height(grid),creator.InventorySize-1,unique_id);
var Quantity = ds_grid_get(grid,1,GridYValue);
var TitleText = item.name;

var IsAmmo = variable_struct_exists(item,"projectile_type");
var IsRangedWeapon = variable_struct_exists(item,"capacity");

if(IsAmmo) {TitleText = item.name + " (" + string(Quantity) + ")"};
if(IsEquipped) {TitleText = TitleText + " (equipped)"};

if ( (MyDisplacement >= -158) and (MyDisplacement <= 135) ){
	
	Interactable = 1;	
	draw_self();	
	draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1);

};

#region cutoff for text and shadows
//bottom cutoff
if ( (MyDisplacement < -158) and (MyDisplacement > -192) ){
	
	Interactable = 0;
	
	var BottomBound = Ycent + (188*scale);
	var Difference = (y+(36*scale)) - BottomBound;
	var Height = 36-(Difference/scale);
	draw_sprite_general(sprite_index,image_index,0,0,313,Height,bbox_left,y,scale,scale,0,c_white,c_white,c_gray,c_gray,1)
	
	if( abs(Height) > 23 ) {
		draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1)
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
		draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1)
		Interactable = 1;
	};
};
#endregion

if(Selected = 1) {
	var ImageScale = 3;
	var _Color = make_color_rgb(164,128,2);
	gpu_set_fog(1,_Color,1,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+(156*scale),Ycent-(60*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+(160*scale),Ycent-(64*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+(156*scale),Ycent-(64*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+(160*scale),Ycent-(60*scale),ImageScale,ImageScale,0,c_white,1);
	gpu_set_fog(0,_Color,1,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+(158*scale),Ycent-(62*scale),ImageScale,ImageScale,0,c_white,1);
	
	if(IsRangedWeapon) {
		var Ammo = ds_grid_get(grid,3,GridYValue);		
		var AmmoCap = item.capacity;
		var AmmoLeft = ds_grid_get(grid,4,GridYValue);	
		if(unique_id = MyPlayer.wpn_active_id) {AmmoLeft = MyPlayer.magazine_active};	
		var _String = Ammo.name+" ("+string(AmmoLeft)+"/"+string(AmmoCap)+")";
		var _Color = c_yellow;//make_color_rgb(255,205,70);
		draw_text_ext_transformed_color(Xcent+(158*scale),Ycent-(9*scale),_String,1,40000,scale*0.75,scale*0.75,0,_Color,_Color,_Color,_Color,1);
	};
};
