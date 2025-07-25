		
//returns a value given an input and a do not exceed (asymptote) limit
//can adjust divisor value to change curve if desired
#region Stats asymptote function: allows for infinitely scaling, exponentially reducing returns on stats
function StatAsymptote(Input,PeakValue,PeakDivisor=100,Divisor=100) {	
	
	var PeakAdjusted = PeakValue/PeakDivisor;
	
	var X = Input;
	var Numerator = PeakAdjusted*X;
	var Denominator = ( (1/Divisor)*X )+3;
	
	return (Numerator/Denominator);
	
}; //asymptote function end bracket
#endregion

#region Stats calculator: calculates stats from core attributes and modifiers
function PlayerStatsCalculator() {
	 
	AGI = Base.AGI + Mod.AGI;
	CHR = Base.CHR + Mod.CHR;
	DEX = Base.DEX + Mod.DEX;
	END = Base.END + Mod.END;
	INT = Base.INT + Mod.INT;
	LCK = Base.LCK + Mod.LCK;
	PER = Base.PER + Mod.PER;
	STR = Base.STR + Mod.STR;	
	WIL = Base.WIL + Mod.WIL;
	 
	BaseMaxHP = StatAsymptote( (Base.END*9) + (Base.LCK/3) + (Base.WIL/2) , 1000);
	MaxHP = StatAsymptote( (END*9) + (LCK/3) + (WIL/2) , 1000);
	MaxStamina = StatAsymptote( (END*2.5) + (AGI/4) + (WIL/4) , 300); 
	MaxWill = StatAsymptote(WIL*3, 300);
	
	CarryWeight = StatAsymptote( (STR*4) + (END/2) + (WIL/4) , 600);  
	
	CritChance = (StatAsymptote(LCK , 500))/1000;
	CritMod = (StatAsymptote( (100+PER) + (LCK/2) , 350 ))/100; 
	
	//+++++++++++++++++++++++++++++++++++++++++++++++++++ HP STUFF +++++++++++++++++++++++++++++++++++++++++++
	
	hp_body_head_max = (BaseMaxHP*0.11);
	hp_body_torso_max = (BaseMaxHP*0.23);
	hp_body_armL_max = (BaseMaxHP*0.13);
	hp_body_armR_max = (BaseMaxHP*0.13);
	hp_body_legL_max = (BaseMaxHP*0.2);
	hp_body_legR_max = (BaseMaxHP*0.2);
	
	//++++++++++++++++++++++++++++++ MOVESPEED CALCS (complicated) +++++++++++++++++++++++++

	/*
	var reactor_power = ((reactor_output/100)/2) + 0.5 //what is our reactor output?
	var AGI_Mod = power(AGI,(1/3))*4 //derive main component of movespeed from agility

	//check if our legs are power armored
	if(is_array(armor_legL_item)){ //is our left leg power armored?
		if(armor_legL_item[11] = "power") {legL_Power_Armored = 1}
		else{legL_Power_Armored = 0}
	}
	else{legL_Power_Armored = 0}

	if(is_array(armor_legR_item)){ //is our right leg power armored?
		if(armor_legR_item[11] = "power") {legR_Power_Armored = 1}
		else{legR_Power_Armored = 0}
	}
	else{legR_Power_Armored = 0}

	//modify reactor modifier
	if(powered = 0) {reactor_power = 1} //if we are not powered, set multiplier to 1 (modifies nothing as there is no power)
	if(!legR_Power_Armored and legL_Power_Armored and powered) {reactor_power = reactor_power/1.25} //if we have only one powered leg and power, reactor modifies speed less
	if(legR_Power_Armored and !legL_Power_Armored and powered) {reactor_power = reactor_power/1.25} //if we have only one powered leg and power, reactor modifies speed less
	if(!legR_Power_Armored and !legL_Power_Armored and powered) {reactor_power = 1} //if we have no powered legs but power, reactor doesn't affect movespeed

	var BaseSpeed = AGI_Mod 
	var legL_Mod = BaseSpeed*0.2*legL_Power_Armored*!powered //subtract 20% of speed if one leg is armored but no power
	var legR_Mod = BaseSpeed*0.2*legR_Power_Armored*!powered //subtract an additional 20% of speed if one leg is armored but no power
	var AdjustedSpeed = (BaseSpeed - legL_Mod - legR_Mod) * reactor_power //adjust final speed with reactor modifier

	var WeightlessMoveSpeed = clamp(AdjustedSpeed,0,38) / (LegsCrippled + 1) //clamp movespeed to min and max

	//+++++++++++++++++++++++++++++++++++++++++++++++ BASE RESISTANCES ++++++++++++++++++++++++++++++++++++++++

	//bolt pistol hits for 20 dmg
	basePhys = ceil(END/20) //max 5 physical resist
	baseTher = ceil(END/10) //max 10 thermal resist
	baseCryo = ceil(END/10) //max 10 cold resist
	baseCorr = ceil(END/30) //max 4 corrosive resist
	baseRadi = ceil(END/30) //max 4 radiation resist
	baseElec = ceil(END/30) //max 4 shock resist
	baseHazm = ceil(END/30) //max 4 hazmat/poison resist
	baseWarp = ceil(INT/10) + ceil(WIL/10) //max 20 warp resist (DENY THE WITCH!)
	basePoise = ceil(STR/5) + ceil(END/10) + ceil(WIL/10) //max 40 poise

	baseBleed = END*3 + ceil(LCK/3)
	basePoison = END*3 + ceil(LCK/3)
	
	//++++++++++++++++++++++++++++++++++++++++++++++ CARRY WEIGHT STUFF +++++++++++++++++++++++++++++++++++++++
	if(instance_exists(obj_ic)){
		var Weight = obj_ic.InvWeight
		var Capacity = CarryWeight
		var Ratio = (Weight/Capacity)*100
		var ExponentDenom = power(2,(Ratio/30))
		var Modifier = 1-(1/ExponentDenom)
		var FinalMod = 1-(Modifier/2)
		obj_ic.SpeedPenalty = string(100*(Modifier/2)) + "%"
		
		MoveSpeed = WeightlessMoveSpeed*FinalMod
		if(Weight > Capacity) {cansprint = 0} else{cansprint = 1}
	}
	*/
}; //function end bracket
#endregion