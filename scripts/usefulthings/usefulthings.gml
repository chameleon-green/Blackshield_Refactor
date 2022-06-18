
//returns a value given an input and a do not exceed (asymptote) limit
//can adjust divisor value to change curve if desired
function StatAsymptote(Input,PeakValue,PeakDivisor=100,Divisor=100) {	
	
	var PeakAdjusted = PeakValue/PeakDivisor;
	
	var X = Input;
	var Numerator = PeakAdjusted*X;
	var Denominator = ( (1/Divisor)*X )+1;
	
	return round(Numerator/Denominator);
	
}; //asymptote function end bracket