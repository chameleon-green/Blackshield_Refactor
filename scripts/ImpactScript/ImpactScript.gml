/*
Define bullet object to collide with, a string for the limb name, and optionally an array of strings for multiple limbs
The limb string name must have array variables associated with it to work as follows (example: left leg):
	armor_legL[0,0,0] where 0 = armor item, 1 = item uniqueID, and 2 = armor durability ratio
*/

#region Impact damage processing with resistances

function ImpactDamageProcessing(Bullet,Limb,CollisionsList,Enemy=0){
	if(instance_exists(Bullet)){
			if((Bullet.IFF != IFF) && (ds_list_find_index(CollisionsList,Bullet) = -1)){
				
				//determine what we will use to resist the incoming damage, and the durability of our armor
				var ResistArray = variable_instance_get(id,"resist_" + Limb);
				var ArmorArray = variable_instance_get(id, "armor_" + Limb);
				var DRatio = ArmorArray[2];
				var Damage = Bullet.damage;
								
				if(Bullet.damage_type = "physical") {var resist = clamp((ResistArray[0]*DRatio)+resist_base[0]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "thermal") {var resist = clamp((ResistArray[1]*DRatio)+resist_base[1]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "cryo") {var resist = clamp((ResistArray[2]*DRatio)+resist_base[2]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "corrosive") {var resist = clamp((ResistArray[3]*DRatio)+resist_base[3]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "radiation") {var resist = clamp((ResistArray[4]*DRatio)+resist_base[4]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "electric") {var resist = clamp((ResistArray[5]*DRatio)+resist_base[5]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "biohazard") {var resist = clamp((ResistArray[6]*DRatio)+resist_base[6]-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "warp") {var resist = clamp((ResistArray[7]*DRatio)+resist_base[7]-Bullet.penetration,0,9999999)};
				else {return 0; exit};
				
				if(Damage <= resist){
					
					audio_play_sound(choose(snd_impact_metal1,snd_impact_metal2,snd_impact_metal3),1,0,1,0,random_range(0.9,1.1));
			
					if(!Enemy){ //damage our armor durability based on how much the damage compares to our resist
						var ItemID = ArmorArray[1];
						if(ItemID != -1) {					
							var Grid = MyIC.grd_inv_armr;
							var YVal = ds_grid_value_y(Grid,0,0,ds_grid_width(Grid),ds_grid_height(Grid),ItemID);
							if(YVal != -1){
								var CurrentDurability = ds_grid_get(Grid,2,YVal);
								var DuraLoss = clamp(Damage*(Damage/resist),1,9999);
								var NewDurability = clamp(CurrentDurability-DuraLoss,0,9999999999999);								
								ds_grid_set(Grid,2,YVal,NewDurability);
								ArmorArray[2] = clamp(NewDurability/ArmorArray[0].durability_max,0.2,1);
								ArmorArray[3] = NewDurability/ArmorArray[0].durability_max;
							};
						}; //item ID check
					}; //enemy check
					else{};

					Bullet.hp = 0;
					Bullet.endBeam = 1;
					return 0;
				};
				else if(Damage > resist) {
					
					audio_play_sound(choose(snd_impact_metal_penetrate1,snd_impact_metal_penetrate2,snd_impact_metal_penetrate3),1,0,1,0,random_range(0.9,1.1));
					audio_play_sound(choose(snd_impact_gore1,snd_impact_gore2,snd_impact_gore3),1,0,0.75,0,random_range(0.9,1.1));
					
					if(Bullet.IsBeam) {
						var oX = Bullet.x;
						var oY = Bullet.y;
						var BeamDirection = Bullet.direction;
						var BeamLength = Bullet.beamLength; //point_distance(oX,oY,x,y)-10;
						var SplashX = oX + (lengthdir_x(BeamLength,BeamDirection));
						var SplashY = oY + (lengthdir_y(BeamLength,BeamDirection));
					};
					else{
						var SplashX = Bullet.x;
						var SplashY = Bullet.y;
						
					};
				
					instance_create_depth(SplashX,SplashY,depth-1,oprt_splatter,{image_angle : Bullet.direction-90});
					
					var LimbVariable = variable_instance_get(id,"hp_body_"+Limb);
					var NetDamage = Damage - resist;
					variable_instance_set(id,"hp_body_"+Limb,LimbVariable-NetDamage);
					HP -= NetDamage;
					if(!Enemy){ //damage our armor durability based on how much the damage compares to our resist
						var ItemID = ArmorArray[1];
						if(ItemID != -1) {	
							var Grid = MyIC.grd_inv_armr;
							var YVal = ds_grid_value_y(Grid,0,0,ds_grid_width(Grid),ds_grid_height(Grid),ItemID);
							if(YVal != -1){
								var CurrentDurability = ds_grid_get(Grid,2,YVal);
								var DuraLoss = Damage;//NetDamage;
								var NewDurability = clamp(CurrentDurability-DuraLoss,0,9999999999999);								
								ds_grid_set(Grid,2,YVal,NewDurability);
								ArmorArray[2] = clamp(NewDurability/ArmorArray[0].durability_max,0.2,1);
								ArmorArray[3] = NewDurability/ArmorArray[0].durability_max;
							};
						}; //item ID check
					Bullet.hp -= resist;
					Bullet.damage = Bullet.hp;
					if(Bullet.hp <= Bullet.fuse) {Bullet.kill = 1};
					}; //enemy check
					else{};
									
					return NetDamage;
				};
				
			}; //IFF check
			return 0;
	}; //bullet instance exists bracket
	return 0;	 
}; //function end bracket

#endregion

#region impact script
function ImpactScript(BulletObject,Limb,HitboxArray,CollisionsList,Precise=0){
	
	var Impacts_List = ds_list_create();
	var Impacts = collision_rectangle_list(x-HitboxArray[0],y-HitboxArray[1],x-HitboxArray[2],y-HitboxArray[3],BulletObject,Precise,false,Impacts_List,false);
	var ImpactCount = 0; //impact counter for while loop
	var TotalDamage = 0; //damage this frame, used to measure amputations
	var MultipleLimbs = is_array(Limb);
	
	while(ImpactCount < Impacts) {	
		var Bullet = Impacts_List[| ImpactCount];		
		//if we have one limb, do the stuff to that limb
			if(!MultipleLimbs){
				var AmputationThreshold = 1.5*variable_instance_get(id,"hp_body_" + Limb + "_max");
				var LimbArray = variable_instance_get(id, "armor_" + Limb);
				LimbArray[4] += ImpactDamageProcessing(Bullet,Limb,CollisionsList);
				if(LimbArray[4] >= AmputationThreshold) {LimbArray[5] = true};
			};
		//if we have an array of limbs, randomly determine one to be hit
			else{
				var Pick = irandom_range(0,array_length(Limb)-1);
				var ChosenLimb = Limb[Pick];
				var LimbArray = variable_instance_get(id, "armor_" + ChosenLimb);
				LimbArray[4] += ImpactDamageProcessing(Bullet,ChosenLimb,CollisionsList);
				var AmputationThreshold = 1.5*variable_instance_get(id,"hp_body_" + ChosenLimb + "_max");
				if(LimbArray[4] >= AmputationThreshold) {LimbArray[5] = true};			
			};
			
			//add our projectile to the collisions list, so it doesn't continuously damage us 
			if(ds_list_find_index(CollisionsList,Bullet) = -1) {ds_list_add(CollisionsList,Bullet)};
			ImpactCount++;
	}; //while loop bracket
	
	//clear out delta damage
	if(!MultipleLimbs){
		var LimbArray = variable_instance_get(id, "armor_" + Limb);
		LimbArray[4] = 0;
	};
	else{
		var i = 0;
		while (i<(array_length(Limb))) {
			var ChosenLimb = Limb[i];
			var LimbArray = variable_instance_get(id, "armor_" + ChosenLimb);
			LimbArray[4] = 0;
			i++;
		};			
	};
			
	ds_list_destroy(Impacts_List);
}; //function end bracket
#endregion 
