// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ButtonRegionCenter(x,y,Left,Right,Top,Bottom,Scale=1){
	
	var Xcent = window_get_width()/2;
	var Ycent = window_get_height()/2; 
	var LeftBorder = Xcent - (Left*Scale);
	var RightBorder = Xcent - (Right*Scale);
	var TopBorder = Ycent - (Top*Scale);
	var BottomBorder = Ycent - (Bottom*Scale);
	
	if( (x>LeftBorder) && (x<RightBorder) && (y>BottomBorder) && (y<TopBorder) ) {
		return 1;
	};
};

function ButtonDrawCenter(Left,Right,Top,Bottom,Scale=1){
	
	var Xcent = window_get_width()/2;
	var Ycent = window_get_height()/2; 
	var LeftBorder = Xcent - (Left*Scale);
	var RightBorder = Xcent - (Right*Scale);
	var TopBorder = Ycent - (Top*Scale);
	var BottomBorder = Ycent - (Bottom*Scale);
	
	draw_rectangle(LeftBorder,TopBorder,RightBorder,BottomBorder,1);
};