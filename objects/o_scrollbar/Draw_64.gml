var Xcent = display_get_gui_width()/2;
var Ycent = display_get_gui_height()/2; 
scale = creator.scale;
image_xscale = scale;

x = (Xcent-(298*scale));
var BgY = (Ycent - (133*scale));
var BgYBar = (Ycent - (118*scale));

if(!creator.visible) {instance_destroy(self); creator.MyScrollbar = 0};

//---------------------------------------------- Coordinate stuff ---------------------------------------------

DisplacementMod = clamp(item_count/9,1,999999999999999); //how far should the items move relative to the scroll? allows for very long item lists
BarLength = 292 - ( clamp(item_count-9,0,99999999999999) * (36/DisplacementMod) );  //  40/4, 4 being the multiplier found in obj_inventory_item
ScaleMod = 292/BarLength;
image_yscale = scale/ScaleMod;

//----------------------------------------------- Mouse Stuff -----------------------------------

Mouse_X = creator.Mouse_X;
Mouse_Y = creator.Mouse_Y;
var Click = mouse_check_button_pressed(mb_left);
var ClickHold = mouse_check_button(mb_left);
var touching = point_in_rectangle(Mouse_X,Mouse_Y,bbox_left,bbox_top,bbox_right,bbox_bottom);

var BarHeight = 292*scale;
var MyHeight = 292*image_yscale;
var MaxDisplacementHeight = BgY + BarHeight - MyHeight + (15*scale);

if(Click && touching) {DeltaY = (y-Mouse_Y); dragging = 1};
if(dragging && ClickHold) {
	var YY = Mouse_Y + DeltaY;
	if( (YY <= MaxDisplacementHeight)&&(YY >= BgYBar) ){
		y = YY
	};	
	if(YY < BgYBar) {y = BgYBar};
	if(YY > MaxDisplacementHeight) {y = MaxDisplacementHeight};
};
if(!ClickHold) {dragging = 0};

Offset = y - Ycent

if(reset) {reset = 0; y = BgYBar};

//----------------------------------------------- Drawing -------------------------------------------------


draw_sprite_ext(sprite_index,0,x,BgY,scale,scale,0,c_white,1);
draw_self();