
//calculates damage, given an entity and a weapon
function MeleeDamageCalculator(entity,weapon){
	
	var ScalingArray = weapon.scalings //where are we getting our scalings?
	var ScalingCount = array_length(ScalingArray); //how many scalings do we have?
	var BaseDamage = weapon.damage;
	var DamageMod = 0;
	
	for(var i=0; i<ScalingCount; i++) {
		var Scaling = ScalingArray[i]; //what is our scaling string?
		var ScalingStat = (string_char_at(Scaling,1) + string_char_at(Scaling,2) + string_char_at(Scaling,3) ); //what is the stat string?
		var ScalingValue = real(string_digits(Scaling))/100; //what percentage does this scaling scale by?
		var EntityStat = variable_instance_get(entity,ScalingStat); //what is our stat to boost damage with?
		
		DamageMod += EntityStat*ScalingValue
	};
	
	return(BaseDamage + DamageMod);
		
}; //damage calc end bracket