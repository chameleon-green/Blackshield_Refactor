var _scl = 1.01
var Sprite = mainsprite;

//draw_self();

var HalfPillar = 24; //half of pillar subimage width so we can center it on the cover edges
var Subimage = [seed_pillars[0][0],seed_pillars[array_length(seed_pillars)-1][0]]; //left and right subimages
if(cells[0] = -1) {Subimage[0] = seed_pillars[0][0]}; //check if leftmost pillar has an upper cell that needs support
if(cells[array_length(cells)-1] = -1) {Subimage[1] = seed_pillars[array_length(seed_pillars)-1][0]}; //check if rightmost pillar has an upper cell that needs support
draw_sprite_ext(Sprite,Subimage[0],bbox_left-HalfPillar,y,1,seed_pillars[0][2],0,c_white,1); //draw left pillar
draw_sprite_ext(Sprite,Subimage[1],bbox_right-HalfPillar,y,1,seed_pillars[array_length(seed_pillars)-1][2],0,c_white,1); //draw right pillar

for(var i=1; i<sizex; i++){	//draw repeating pillar sprites between our cell bits based on width
	
	var CellWidth = 144; //width of one cover cell (window bit)
	var HalfPillarWidth = 24; //width of one half pillar
	var Xoffset = (i*CellWidth) + ((i+(i-1))*HalfPillarWidth); 	//1 = 1, 2 = 3, 3 = 5, 4 = 7,
	var Subimage = seed_pillars[i][0];
	var SubimageBG = seed_pillars[i][3]
	var Yscale = seed_pillars[i][2];
	var Xscale = seed_pillars[i][1];
	var XscaleOffset = 0;
	if(Xscale =-1) {XscaleOffset = 48};
	
	//draw_sprite_ext(Sprite,SubimageBG,x+Xoffset+XscaleOffset,y,Xscale,Yscale,0,c_ltgray,1); //draw pillar bits
	draw_sprite_ext(Sprite,Subimage,x+Xoffset+XscaleOffset,y,Xscale,Yscale,0,c_white,1); //draw pillar bits

};



draw_text(x,bbox_top-32,seed_pillars);


for(var i=0; i<sizex; i++){	//draw repeating cell sprites (window bits) based on our width, and curb if we are a bottom layer
	
	var CurbWidth = 192;
	var CellWidth = 144; //width of one cover cell (window bit)
	var PillarWidth = 48; //width of one pillar
	var Xoffset = (i*(CellWidth+PillarWidth)); 
	var Subimage = seed_cells[i][0];
	var SubimageBG = seed_cells[i][2];
	
	var Xscale = seed_cells[i][1];
	var XscaleOffset = 0;
	if(Xscale =-1) {XscaleOffset = 144};
	
	//draw_sprite_ext(Sprite,SubimageBG,x+HalfPillar+Xoffset+XscaleOffset,y,Xscale,1,0,c_ltgray,1);
	draw_sprite_ext(Sprite,Subimage,x+HalfPillar+Xoffset+XscaleOffset,y,Xscale,1,0,c_white,1); //draw cell bits
	if(col_ground) {
		draw_sprite_ext(Sprite,0,x+i*CurbWidth-(PillarWidth/2),y+32,1,1,0,c_white,1); //draw curb bits if we are on the ground
	}; 
	if(col_ground) {
		draw_sprite_ext(Sprite,seed_rubble[i][0],x+i*CurbWidth-(PillarWidth/2),y+32,1,1,0,c_white,1); //draw rubble bits if we are on the ground
	};	
};


//draw ends of curb if on the ground
if(col_ground) {
		var HalfPillarWidth = 24; //width of one half pillar
		draw_sprite_ext(Sprite,21,bbox_left-HalfPillarWidth,y+32,-1,1,0,c_white,1); //draw curb bits if we are on the ground
		draw_sprite_ext(Sprite,21,bbox_right+HalfPillarWidth,y+32,1,1,0,c_white,1); //draw curb bits if we are on the ground
	};

	
	