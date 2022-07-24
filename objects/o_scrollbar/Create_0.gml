image_index = 1;
image_speed = 0;

dragging = 0;
DeltaY = 0;
reset = 0;

var Xcent = window_get_width()/2;
var Ycent = window_get_height()/2;
y = Ycent - (118*creator.scale);

item_count = 0;

DisplacementMod = clamp(item_count/8,1,999999999999999);
BarLength = 292;
Offset = 0;

