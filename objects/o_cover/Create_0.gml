
//+++++++++++++++++++++++++++++++++++++++++++ SIZE AND OTHER COVER COLLISIONS ++++++++++++++++++++++++++++++++++++++++
//one cover with pillars = 224 x 224
sizex = round(image_xscale);	//round( (image_xscale*64)/224 )
sizey = round(image_yscale);	//round( (image_yscale*64)/224 )

cells = array_create(sizex,0); //array populated by our terrain segments
pillars = array_create(sizex+1,0); //array for our pillars
rubble = array_create(sizex,0);
myplatform = 0

for(var r=0; r<array_length(rubble); r++){ //selects random frames for rubble decorations 
	rubble[r] = irandom_range(0,4)
};

col_bot = 0
col_top = 0
col_ground = 0
bot_obj = 0
top_obj = 0

//one pillar = 48px, one window = 144px

if(place_meeting(x,y+1,o_cover)) { //checks if there is a cover object below us for multi-story ruins
	bot_obj = instance_place(x,y+1,o_cover);
	col_bot = 1;
	};

if(place_meeting(x,y-1,o_cover)) { //checks if there is a cover object above us for multi-story ruins
	top_obj = instance_place(x,y-1,o_cover)
	col_top = 1
	var top_width = abs(top_obj.bbox_left-top_obj.bbox_right)
	var top_cell_count = round(top_width/192) //finds the cell count of the upper level
	
	for(var c=0; c<array_length(cells); c++){ 
		if(top_obj.bbox_left = bbox_left + 192*c) { //checks to see where the bbox_left of the upper story is
			cells[c] = -1
			for(var t=0; t<top_cell_count; t++){ //after finding left side of top level, finds all cells above us
				cells[c+t] = -1
			}
		}
	}
};
	
if(place_meeting(x,y+33,o_platform)) { //checks if we are the ground level
	col_ground = 1;
};
	
if(!col_ground) { //creates a platform for this floor if we are above the ground
	myplatform = instance_create_depth(x,y,depth,o_platform,{ //pre creation variable setting
		image_xscale : sizex*(192/32),
		image_yscale : 0.5,		
	});
	with(myplatform) { //post creation variable setting
		draw_tiles_top = 0;
		creator = other;		
	};
};

//+++++++++++++++++++++++++++++++++++++++++++++ INITIALIZE SELF +++++++++++++++++++++++++++++++++++++++++++++++++

randomize();

depth = -50
image_speed = 0


for (var i=0; i<(sizex+1); i++) { //we need to have 1 more pillar than there are cells, so we add 1 to sizex
	
	if(i < (sizex+1)) {
		var CurrentSupportCell = ( cells[clamp(i,0,array_length(cells)-1)] = -1 ); //check the current cell for pillar support, clamping it at the max number of cells
		var PrevSupportCell = ( cells[clamp(i-1,0,9999)] = -1 ); //check the previous cell for pillar support, clamping at 0
		var SupportCell = (CurrentSupportCell or PrevSupportCell);
		if (SupportCell) {seed_pillars[i] =  [irandom_range(12,15),choose(-1,1),1,irandom_range(12,15)]} //give the support pillars solid ones
		else{seed_pillars[i] = [irandom_range(7,11),choose(-1,1),random_range(0.66,1.33),irandom_range(7,11)]}; //give non support pillars fractured/short ones
		
		//re-roll randomizer if we have the same result as the prev entry
		
		if( SupportCell and (seed_pillars[i] = seed_pillars[clamp(i-1,0,9999)]) ){
			seed_pillars[i] =  [irandom_range(12,15),choose(-1,1),1,irandom_range(12,15)]
		}
		else if (seed_pillars[i] = seed_pillars[clamp(i-1,0,9999)]){
			seed_pillars[i] = [irandom_range(7,11),choose(-1,1),random_range(0.66,1.33),irandom_range(7,11)]
		};
	};
};


for (var i=0; i<sizex; i++) {
	
	var SupportCell = ( cells[i] = -1 );
	if(SupportCell){
		seed_cells[i] = [irandom_range(1,2),choose(-1,1),irandom_range(3,6)];
	}
	else {
		seed_cells[i] = [irandom_range(3,6),choose(-1,1),irandom_range(3,6)];
	};
	
};

for (var i=0; i<sizex; i++) {
	seed_rubble[i] = [irandom_range(16,20),choose(-1,1)];
	if( (i>0) and (seed_rubble[i] = seed_rubble[i-1]) ) { //re-rolls randomizer if last entry is the same is current
		seed_rubble[i] = [irandom_range(16,20),choose(-1,1)];
	};
};

//seed_pillars = [choose(7,8,9),choose(7,8,9),choose(7,8,9),choose(7,8,9),choose(7,8,9)]; //frames 7,8,9 are ruined pillars, 10 reserved for full pillar
//seed_cells = [choose(1,2),choose(1,2),choose(1,2,3,4,5,6),choose(1,2,3,4,5,6),choose(1,2,3,4,5,6),choose(1,2,3,4,5,6)]; //entries 0 and 1 used for full cells that have uuper levels to support
//seed_rubble = [choose(11,12,13,14,15),
//			   choose(11,12,13,14,15),
//			   choose(11,12,13,14,15),
//			   choose(11,12,13,14,15),
//			   choose(11,12,13,14,15)];

mainsprite = sp_cover_ruins;

sound[3] = 0//snd_impact_stone1
sound[2] = 0//snd_impact_stone2
sound[1] = 0//snd_impact_stone3
sound[0] = 0//snd_impact_stone4



barrier_right = instance_create_depth(x,y,50,o_barrier);
with (barrier_right){
		image_xscale = 1;
		image_yscale = 150;
		x = other.bbox_right + 18;
		y = other.y+12;
		//sound = other.sound
};


barrier_left = instance_create_depth(x,y,50,o_barrier);
with (barrier_left){
		image_xscale = -1;
		image_yscale = 150;
		x = other.bbox_left - 18;
		y = other.y+12;
		//sound = other.sound
};


