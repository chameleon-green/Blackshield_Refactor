
var Xcent = display_get_gui_width()/2;
var Ycent = display_get_gui_height()/2; 
var XoffS = Xoffset*scale;
var YoffS = Yoffset*scale;

var BgY = (Ycent-(133*scale)+YoffS);
var BgYBar = (Ycent-(118*scale)+YoffS);

var BarHeight = 292*scale;
var MyHeight = 292*image_yscale;
var MaxDisplacementHeight = BgY + BarHeight - MyHeight + (15*scale);

//------------------------------------------------------------------

var DisplacementPerTick = (BgYBar - MaxDisplacementHeight)/15;

var YY = y+DisplacementPerTick;
	
if( (YY <= MaxDisplacementHeight)&&(YY >= BgYBar) ){y = YY};	
if(YY < BgYBar) {y = BgYBar};
if(YY > MaxDisplacementHeight) {y = MaxDisplacementHeight};
