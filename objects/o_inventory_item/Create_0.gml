Mouse_X = 0;
Mouse_Y = 0;
scale = creator.scale;
Xoffset = creator.Xoffset; 
Yoffset = creator.Yoffset; 

var Ycent = window_get_height()/2;
y = Ycent - (133*scale) + (yoffset*36*scale) + (Yoffset*scale);
ScrollBarOffset = (y - scrollbar.y);

Interactable = 1;


