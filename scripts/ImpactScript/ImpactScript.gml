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
								
				if(Bullet.damage_type = "physical") {var resist = clamp((ResistArray[0]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "thermal") {var resist = clamp((ResistArray[1]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "cryo") {var resist = clamp((ResistArray[2]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "corrosive") {var resist = clamp((ResistArray[3]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "radiation") {var resist = clamp((ResistArray[4]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "electric") {var resist = clamp((ResistArray[5]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "biohazard") {var resist = clamp((ResistArray[6]*DRatio)-Bullet.penetration,0,9999999)};
				else if(Bullet.damage_type = "warp") {var resist = clamp((ResistArray[7]*DRatio)-Bullet.penetration,0,9999999)};
				else {return 0; exit};
				
				if(Damage <= resist){
					
					audio_play_sound(choose(snd_impact_metal1,snd_impact_metal2,snd_impact_metal3),1,0,1,0,random_range(0.9,1.1));
									
					if(!Enemy){ //damage our armor durability based on how much the damage compares to our resist
						var ItemID = ArmorArray[1];
						var Grid = MyIC.grd_inv_armr;
						var YVal = ds_grid_value_y(Grid,0,0,ds_grid_width(Grid),ds_grid_height(Grid),ItemID);
						if(YVal != -1){
							var CurrentDurability = ds_grid_get(Grid,2,YVal);
							var DuraLoss = 1;//clamp(Damage*(Damage/resist),1,9999);
							var NewDurability = clamp(CurrentDurability-DuraLoss,0,9999999999999);								
							ds_grid_set(Grid,2,YVal,NewDurability);
							ArmorArray[2] = clamp(NewDurability/ArmorArray[0].durability_max,0.2,1);
						};
					}; //enemy check
					else{};
					
					
					
					instance_destroy(Bullet);
				};
				else if(Damage > resist) {
					
					var LimbVariable = variable_instance_get(id,"hp_body_"+Limb);
					var NetDamage = Damage - resist;
					variable_instance_set(id,"hp_body_"+Limb,LimbVariable-NetDamage);
					if(!Enemy){ //damage our armor durability based on how much the damage compares to our resist
						var ItemID = ArmorArray[1];
						var Grid = MyIC.grd_inv_armr;
						var YVal = ds_grid_value_y(Grid,0,0,ds_grid_width(Grid),ds_grid_height(Grid),ItemID);
						if(YVal != -1){
							var CurrentDurability = ds_grid_get(Grid,2,YVal);
							var DuraLoss = NetDamage;
							var NewDurability = clamp(CurrentDurability-DuraLoss,0,9999999999999);								
							ds_grid_set(Grid,2,YVal,NewDurability);
							ArmorArray[2] = clamp(NewDurability/ArmorArray[0].durability_max,0.2,1);
						};
					Bullet.hp -= resist;
					Bullet.damage = Bullet.hp;
					if(Bullet.hp <= Bullet.fuse) {instance_destroy(Bullet)};
					}; //enemy check
					else{};
					
					
					return NetDamage;
				};
				
			}; //IFF check
			 
	}; //bullet instance exists bracket
		 
}; //function end bracket

#endregion


#region impact script
function ImpactScript(BulletObject,Limb,HitboxArray,CollisionsList,Precise=0){
	
	var Impacts_List = ds_list_create();
	var Impacts = collision_rectangle_list(x-HitboxArray[0],y-HitboxArray[1],x-HitboxArray[2],y-HitboxArray[3],BulletObject,Precise,false,Impacts_List,false);
	var ImpactCount = 0; //impact counter for while loop
	var TotalDamage = 0; //damage this frame, used to measure amputations
	
	while(ImpactCount < Impacts) {
		var MultipleLimbs = is_array(Limb);
		var Bullet = Impacts_List[| ImpactCount];
		
		//if we have one limb, do the stuff to that limb
			if(!MultipleLimbs){
				ImpactDamageProcessing(Bullet,Limb,CollisionsList);
			};
		//if we have an array of limbs, randomly determine one to be hit
			else{
				var Pick = irandom_range(0,array_length(Limb)-1); 						
				ImpactDamageProcessing(Bullet,Limb[Pick],CollisionsList);			
			};
			
			//add our projectile to the collisions list, so it doesn't continuously damage us 
			if(ds_list_find_index(CollisionsList,Bullet) = -1) {ds_list_add(CollisionsList,Bullet)};
			ImpactCount++;
	}; //for loop bracket
		
	ds_list_destroy(Impacts_List);
}; //function end bracket
#endregion 
