


repeat(3) {
instance_create_depth(x,y,depth-1,o_bullet,{
			origin_x : x,
			origin_y : y,
			type : o_player.Ammo_Bolt_Standard,
			IFF : "123",
			damage : 40,
			damage_type : "thermal",
			direction : 180,// + random_range(-2,2),
			speed : 10
})

};