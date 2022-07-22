var Xcent = window_get_width()/2;
var Ycent = window_get_height()/2; 
scale = creator.scale;
image_xscale = scale;
image_yscale = 0.25*scale;

x = Xcent-(298*scale); 
var BgY = Ycent - (133*scale);
var BgYBar = Ycent - (118*scale);

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

//----------------------------------------------- Drawing -------------------------------------------------


draw_sprite_ext(sprite_index,0,x,BgY,scale,scale,0,c_white,1);
draw_self();


draw_sprite_ext(sp_xhair,0,x,MaxDisplacementHeight,scale,scale,0,c_white,1);
