
var Xcent = display_get_gui_width()/2;
var Ycent = display_get_gui_height()/2; 

var BgY = Ycent - (133*scale);
var BgYBar = Ycent - (118*scale);

var BarHeight = 292*scale;
var MyHeight = 292*image_yscale;
var MaxDisplacementHeight = BgY + BarHeight - MyHeight + (15*scale);

//------------------------------------------------------------------

var DisplacementPerTick = (BgYBar - MaxDisplacementHeight)/15;

var YY = y-DisplacementPerTick;
	
if( (YY <= MaxDisplacementHeight)&&(YY >= BgYBar) ){y = YY};	
if(YY < BgYBar) {y = BgYBar};
if(YY > MaxDisplacementHeight) {y = MaxDisplacementHeight};
