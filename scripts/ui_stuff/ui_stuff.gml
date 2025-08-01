// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function ButtonRegionCenter(x,y,Left,Right,Top,Bottom,Scale=1,Xoffset=0,Yoffset=0){
	
	var Xcent = (display_get_gui_width()/2) + (Xoffset*Scale);
	var Ycent = (display_get_gui_height()/2) + (Yoffset*Scale);
	var LeftBorder = Xcent - (Left*Scale);
	var RightBorder = Xcent - (Right*Scale);
	var TopBorder = Ycent - (Top*Scale);
	var BottomBorder = Ycent - (Bottom*Scale);
	
	if( (x>LeftBorder) && (x<RightBorder) && (y>BottomBorder) && (y<TopBorder) ) {
		return 1;
	}
	else{return 0};
};

function ButtonDrawCenter(Left,Right,Top,Bottom,Scale=1,Xoffset=0,Yoffset=0){
	
	var Xcent = (display_get_gui_width()/2) + (Xoffset*Scale);
	var Ycent = (display_get_gui_height()/2) + (Yoffset*Scale);
	var LeftBorder = Xcent - (Left*Scale);
	var RightBorder = Xcent - (Right*Scale);
	var TopBorder = Ycent - (Top*Scale);
	var BottomBorder = Ycent - (Bottom*Scale);
	
	draw_rectangle(LeftBorder,TopBorder,RightBorder,BottomBorder,1);
};

function ds_list_draw(list,X,Y) {
	var size = ds_list_size(list);
	for(var i = 0; i < size; i++){
		draw_text(X,Y-(12*size)+(12*i),ds_list_find_value(list,i))
	};
};