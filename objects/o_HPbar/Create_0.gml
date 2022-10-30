image_speed = 0;
image_index = 0;

CL_Yellow = make_color_rgb(247,191,2);
CL_Orange = make_color_rgb(255,121,0);
CL_Red = make_color_rgb(255,60,40);
CL_Screen = make_color_rgb(40,30,20); //CL_Screen = make_color_rgb(40,25,0);
CL_Outline = make_colour_rgb(192,158,2);

ChooseColor = function(Ratio){
	if(Ratio <= 0) {return CL_Screen};
	else if(Ratio > 0 and Ratio <= 0.33) {return CL_Red};
	else if(Ratio > 0.33 and Ratio <= 0.75) {return CL_Orange};
	else if(Ratio > 0.75) {return CL_Yellow};
};