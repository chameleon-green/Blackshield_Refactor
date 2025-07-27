function BeamCast(X,Y,Direction,Length,WallObject){

	//get our first impact from point of origin
	var XX = X+lengthdir_x(Length,Direction);
	var YY = Y+lengthdir_y(Length,Direction);
	var FirstImpact = collision_line(X,Y,XX,YY,WallObject,true,true);
	
	//if we get an impact, proceed. If not, return -1
	if(FirstImpact != noone) {
		
		var DeltaX = XX-X; //gets the difference between point of origin and point of first impact
		var DeltaY = YY-Y; //same as above, but Y axis
		
		while ( (abs(DeltaX) >= 1) || (abs(DeltaY) >= 1) ) {
			//Bisect the probing distance
			DeltaX = (DeltaX/2);
			DeltaY = (DeltaY/2);
			//Check along the new collision line
			var instance = collision_line(X, Y, XX-DeltaX, YY-DeltaY, WallObject, true, true);
			//If something is hit, keep track of it and reduce the total distance to check for
			if (instance != noone){
				FirstImpact = instance;
				XX -= DeltaX;
				YY -= DeltaY;
			};
		};
		var FinalX = XX-DeltaX;
		var FinalY = YY-DeltaY;
		var FinalDist = point_distance(X,Y,FinalX,FinalY)
		var ReturnArray = [FinalX,FinalY,FinalDist];
		return ReturnArray;
	};

	return [-1,-1,-1];
};

function BeamBullet(X,Y,Direction,Range,MasterObject,IFF) {
	
	var ListCol = ds_list_create();
	var XX = X+lengthdir_x(Range,Direction);
	var YY = Y+lengthdir_y(Range,Direction);
	collision_line_list(X,Y,XX,YY,MasterObject,true,true,ListCol,true);
	var ListSize = ds_list_size(ListCol);
	var i = 0;
	
	while(i <= (ListSize-1)) {
		
		var ListEntry = ds_list_find_value(ListCol,i);
		var ObjType = ListEntry.object_index;
		
		//what happens if we touch a platform - kill self, cast beam to position and return impact point
		if(ObjType = o_platform){
			var ReturnArray = BeamCast(X,Y,Direction,Range,o_platform);
			ds_list_destroy(ListCol);
			return ReturnArray;
		}
		
		//what happens if we touch a barrier -
		else if(ObjType = o_barrier) {
			
			//roll to see the cover chance
			var MyChance = irandom_range(0,100); 
			
			//cover check failed, cast to nearest cover and kill self
			if(MyChance < ListEntry.chance) {
				var ReturnArray = BeamCast(X,Y,Direction,Range,o_barrier);
				ds_list_destroy(ListCol);
				return ReturnArray;
			}
			
			//cover check passed, jump past current cover and restart collision_line after the cover we skipped
			else {
				var Width = abs(ListEntry.bbox_left - ListEntry.bbox_right);
				var ToLeft = (X < ListEntry.x);
				
				if(ToLeft) {X = ListEntry.bbox_right+10}
				else {X = ListEntry.bbox_left-10};				
			};
		};
		
		//increment up to check the next entry
		i++;
	};

	ds_list_destroy(ListCol);
	return [-1,-1,-1];
};