

if(corner = 1) {
	
var i = 0;
var ListCol = ds_list_create();
collision_rectangle_list(x-90,y,x+90,y+900,o_navnode,0,1,ListCol,0);

while (i < ds_list_size(ListCol)) {
	
	var Inst = ds_list_find_value(ListCol,i);
	var PlatformCheck = ds_list_create();
	collision_line_list(x,y,Inst.x,Inst.y,o_platform,1,0,PlatformCheck,1);
	
	var LOS = 1;
	if((ds_list_size(PlatformCheck) = 1) && (PlatformCheck[| 0] != creator)) {LOS = 0}; //we hit one platform, and it is not our parent, there is no LOS
	if(ds_list_size(PlatformCheck) > 1) {LOS = 0}; //we hit multiple platforms (inc. parent), there is no LOS
	
	if(LOS && (Inst.corner = 0)) {instance_destroy(Inst)};
	ds_list_destroy(PlatformCheck);
	i++;
};


};





