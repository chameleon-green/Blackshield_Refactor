//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Set scale based on size input +++++++++++++++++++++++++++++++++
var array = explosion_type


//["explosion", 8, 0.75, c_gray, 0, 0, snd_explode_small1], //type, size, smoke mass, smoke max scale, smoke color, frag count, frag lifetime, sound

/*
1 = size
2 = smoke mass
3 = smoke max scale
4 = smoke color
5 = frag count
6 = frag life
7 = sound
*/

size = array[1]*(random_range(0.8,1.2))
image_xscale = size/5
image_yscale = size/5

//+++++++++++++++++++++++++++++++++++++++++++++++++ generate smoke and dust ++++++++++++++++++++++++++++++++++++++++++
var _special = "none";
var Mass = array[2];
var smoke_count = 10
var angle = 360/smoke_count

if(counter < smoke_count){
repeat(smoke_count) {
	counter+=1 
	var angle2 = other.image_angle + angle*other.counter
	with(instance_create_depth(x,y,depth+1,oprt_smoke)) {
		image_blend = array[4] 
		direction = angle2 
		mass = Mass 
		max_scale = array[3]
		//if(_special = "firey") {firey = 1}
		}
}

with(instance_create_depth(x,y,depth+1,oprt_smoke)) {
	image_blend = array[4] 
	max_speed = 0 
	mass = Mass 
	max_scale = array[3]
	//if(_special = "firey") {firey = 1}
	}
}	
	
 //++++++++++++++++++++++++++++++++++++++++++++++++++ throw frags ++++++++++++++++++++++++++++++++++++

if(exploded = 0 and array[5] > 0) {
		exploded = 1
		
		rocket_sound = audio_play_sound_at(array[7],x,y,0,size*60,size*700,1,0,1) 
		
		repeat(array[5]) {
			with(instance_create_depth(x,y,1,o_fragment)){
					damage = other.damage/array[5]
					damage_type = other.damage_type
					hp = other.damage/array[5]
					alarm[0] = array[6]*random_range(0.6,1.3)
			}
		}
}	
//play noise if we got no frags
else if (exploded = 0) {exploded = 1 rocket_sound = audio_play_sound_at(array[7],x,y,0,size*10,size*600,1,0,1)}

//++++++++++++++++++++++++++++++++++++++++++++++++ kill self + creator ++++++++++++++++++++++++++++++++

if(image_index = sprite_get_number(sprite_index)-1) {instance_destroy(self)}
if(creator != undefined) {instance_destroy(self.creator)}
