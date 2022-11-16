
#region Node generation function
function GenerateNodes(NodeDensity){

	var Width = abs(bbox_left - bbox_right);
	var NodeCount = floor(Width/NodeDensity);
	var NodeHoverHeight = 55;
	
	var Angle = degtorad(image_angle);
	var Yoff = tan(Angle)*Width;
	
	var LeftNodeOffset = clamp(sign(Angle),0,1)*Yoff
	var RightNodeOffset = clamp(sign(Angle),-1,0)*Yoff
	
	instance_create_depth(bbox_left+10,bbox_top+LeftNodeOffset-NodeHoverHeight,depth-1,o_navnode,{parent : id});
	instance_create_depth(bbox_right-10,bbox_top+RightNodeOffset-NodeHoverHeight,depth-1,o_navnode,{parent : id});
	
	var i = 1;
	while(i < NodeCount) {
				
		var Spacing = Width/NodeCount;		
		var Yoff2 = Yoff*(i/NodeCount);
		var YPos = bbox_top-Yoff2
		if(Angle > 0) {
			Yoff2 = Yoff*(1-(i/NodeCount));
			YPos = bbox_top+Yoff2;
		};
		
		instance_create_depth(bbox_left+Spacing*i,YPos-NodeHoverHeight,depth-1,o_navnode,{parent : id});
		i++;
	};	
};
#endregion

#region DS list nearest and farthest calculator
//returns the nearest instance to input coordinates from a list of instance IDs
//can only handle 299 instances at once
//returns -1 if the input ds_list is empty
//cover input allows you to specify if it should favor nodes in cover
//popcap allows you to specify to exclude nodes that are too crowded

function ds_list_nearest(list,x,y,cover,popcap=-1) {	
	var toggle = 1;
	var distance_grid = ds_grid_create(2,300);
	var size = ds_list_size(list);

	if(size = 0) {ds_grid_destroy(distance_grid); return 0};

	var i;

	for(i=0; i<size; i++) {
		var instance = list[|i];		
		if(cover) {var distance = point_distance(x,y,instance.x,instance.y)-90000*instance.cover};
		else{var distance = point_distance(x,y,instance.x,instance.y)};
	
		if(popcap > 0) {
			var plist = ds_list_create()
			collision_ellipse_list(instance.x-16,instance.y-16,instance.x+16,instance.y+16,o_enemy,0,true,plist,true)
			var count1 = ds_list_size(plist)	
				if(count1 > 0){
					for(var c=0; c < count1; c++){
						var npc = plist[|c];
						if(npc.hspeed = 0) {distance+=500};
					};
				};
			ds_list_destroy(plist);
		};
			
		ds_grid_add(distance_grid,0,i,instance);
		ds_grid_add(distance_grid,1,i,distance);
	};
	
	var min_distance = ds_grid_get_min(distance_grid,1,0,1,size-1);
	var yy = ds_grid_value_y(distance_grid,1,0,1,299,min_distance);
	var nearest_instance = ds_grid_get(distance_grid,0,yy);

	if(toggle = 1) {var result = nearest_instance; toggle = 0}; //weird bit needed to terminate ds grid before returning
	ds_grid_destroy(distance_grid);

	return result;
};

//same thing, but now the farthest node in LOS

function ds_list_farthest(list,x,y,cover,popcap=-1) {	
	var toggle = 1;
	var distance_grid = ds_grid_create(2,300);
	var size = ds_list_size(list);

	if(size = 0) {ds_grid_destroy(distance_grid); return 0};

	var i;

	for(i=0; i<size; i++) {
	var instance = list[|i];
	if(cover) {var distance = point_distance(x,y,instance.x,instance.y)+90000*instance.cover};
	else{var distance = point_distance(x,y,instance.x,instance.y)};
	
		if(popcap > 0) {
		var plist = ds_list_create();
		collision_ellipse_list(instance.x-100,instance.y-50,instance.x+100,instance.y+50,o_enemy,0,true,plist,true);
		var count1 = ds_list_size(plist)	;
			if(count1 > 0){
				for(var c=0; c < count1; c++){
					var npc = plist[|c];
					if(npc.hspeed = 0) {distance-=500};
				};
			};
			ds_list_destroy(plist);
	};
	
	ds_grid_add(distance_grid,0,i,instance);
	ds_grid_add(distance_grid,1,i,distance);
	};
	

	var max_distance = ds_grid_get_max(distance_grid,1,0,1,size-1);
	var yy = ds_grid_value_y(distance_grid,1,0,1,299,max_distance);
	var farthest_instance = ds_grid_get(distance_grid,0,yy);

	if(toggle = 1) {var result = farthest_instance toggle = 0}; //weird bit needed to terminate ds grid before returning
	ds_grid_destroy(distance_grid);

	return result;
};
#endregion

#region Nodes in line of sight function
//returns a ds_list of all node objects that are not obstructed from view by wall objects from a given x,y
//remember to delete ds grid in object's calling event to prevent memory leak
//currently uses an ellipse to detect nodes within max jump height, but also far below so the AI can drop down off of high ledges 
//max search range for nodes below is currently 2x jump height, configured in the collision_ellipse call
//area argument allows us to define if the seeking is done left/right of target
//for example, if the calling entity is to the left of the target, only seek nodes on left of target

function nodes_in_los(search_radius,wall_object,node_object,x,y,closed_list,area="center") {
	var text;
	var toggle = 1
	var SearchList = ds_list_create();
	var ValidList = ds_list_create();
	var IsClosedList = ds_exists(closed_list,ds_type_list)
	var i;

	var area_offset = 0
	if(area = "left") {area_offset = -search_radius*2.5}
	if(area = "right") {area_offset = search_radius*2.5}

	collision_ellipse_list(
		x+search_radius*2.5+area_offset,
		y-search_radius,
		x-search_radius*2.5+area_offset,
		y+search_radius*2,
		node_object,true,1,SearchList,true
		)
		
	var SLSize = ds_list_size(SearchList);
	if(SLSize = 0) {
		ds_list_destroy(ValidList);
		ds_list_destroy(SearchList);
		return -1
	};

	for(i = 0; i < SLSize; i++) {
		var node = SearchList[|i]
		var LOS = (!collision_line(x,y,node.x,node.y,wall_object,true,1) and !collision_line(x+5,y,node.x,node.y,wall_object,true,1) and !collision_line(x-5,y,node.x,node.y,wall_object,true,1));
			if(IsClosedList = true) {
				var closed = (ds_list_find_index(closed_list,node) != -1)
				if (LOS and !closed) {ds_list_add(ValidList,node)}
			};
		
			if(IsClosedList = false){
				if (LOS) {ds_list_add(ValidList,node)}
			};
	};
	
	ds_list_destroy(SearchList);
	if(toggle = 1) {text = ds_list_write(ValidList) toggle = 0};
	ds_list_destroy(ValidList);
	return text;
};
#endregion

#region  A-Star path calculator

//calculates a path using A* and returns a path of sequential nodes in a ds_list 
//make sure to define wall and node objects properly or this will not work
//parameters: start node, target node, search radius (How far each node can search for others. This is usually defined by maximum jump height)
//max_search_size dictates max size of openlist data structure. The larger it is, the longer an AI
//will search for a path before giving up. Higher values are more performance intensive, but may be
//required for very complex level geometry/large levels with lots of nodes

function nodes_calculate_cost_array(start_node,search_radius,target_node,max_search_size) {
	//++++++++++++++++++++++++++++++++++++++++++++++++ DEFINE YOUR RELEVANT OBJECTS HERE+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	var oSolid = o_platform; //define wall object
	var oNode = o_navnode; //define navigation point object

//++++++++++++++++++++++++++++++++++++++++++ TOUCH SHIT BELOW THIS LINE AT YOUR OWN PERIL +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	var toggle = 1 //our return toggle, so we can delete our path data structure but still return it

	var OpenList = ds_priority_create(); //establish data structures
	var ClosedList = ds_list_create(); //establish data structures
	var ClosedParentList = ds_list_create(); //a list of closedlist's parents
	var StartNode; 
		StartNode[4] = start_node; //what node is this
		StartNode[3] = start_node; //parent of node
		StartNode[2] = 0; //g cost, not relevant for start node
		StartNode[1] = 0; //h cost, not relevant for start node
		StartNode[0] = 0; //f cost (g+h)
	
	ds_priority_add(OpenList,StartNode,0); //add our start position to closed list

	var PathComplete = (ds_list_find_index(ClosedList,target_node) != -1); //we found our target

	//+++++++++++++++++++++++++++++++++++++++++++++++++++++ PATHFINDING LOOP ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	while (!PathComplete and ds_priority_size(OpenList) < max_search_size) { //while our target is not found and we still have nodes unsearched, continue 
	
		if(target_node = -1 or start_node = -1) {break};
	
		var Node = ds_priority_find_min(OpenList);//find cheapest node array 
		ds_priority_delete_value(OpenList,Node); //remove our node from the openlist	
	
		if(is_array(Node)){
			if(ds_list_find_index(ClosedList,Node[4]) = -1) {ds_list_add(ClosedList,Node[4]) ds_list_add(ClosedParentList,Node[3])}; //add to the closed list
			if(Node[4] = target_node) {break}; //if we have added target to closed list, break the loop and stop expanding nodes
	
			//if(ds_list_size(ClosedList) > 15) {return -1}
	
			//Find adjacent nodes and add them to our open list
			var LOSList = ds_list_create();
			ds_list_read(LOSList,nodes_in_los(search_radius,oSolid,oNode,Node[4].x,Node[4].y,-1));
			var LOSListSize = ds_list_size(LOSList);
			var i;
	
			for(i = 0; i < LOSListSize; i++){
			//find the cost of each node
				var NodeArray = 0;
				var NodeID = LOSList[| i];
				var CostG = abs(point_distance(start_node.x,start_node.y,NodeID.x,NodeID.y)) + abs(point_distance(start_node.x,start_node.y,Node[4].x,Node[4].y))
				var CostH = abs(point_distance(target_node.x,target_node.y,NodeID.x,NodeID.y));
				var CostF = ( (1*CostG) + (3*CostH) )/4
		
				NodeArray[4] = NodeID; //set node itself
				NodeArray[3] = Node[4]; //set parent
				NodeArray[2] = CostG;
				NodeArray[1] = CostH;
				NodeArray[0] = CostF;
		
				var ClosedNode = (ds_list_find_index(ClosedList,NodeArray[4]) != -1);
				if(!ClosedNode) {ds_priority_add(OpenList,NodeArray,CostF)};		
			};
			ds_list_destroy(LOSList);
		}; else{break}; //is Node an array?
	
	};

	//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ GENERATE A PATH ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	var PathComplete = (ds_list_find_index(ClosedList,target_node) != -1); //we found our target
	if(PathComplete) {
		var i2;
		var PathList = ds_list_create();
		var ClosedListSize = ds_list_size(ClosedList);
		var InitialNode = ds_list_find_value(ClosedList,ClosedListSize-1); //gets our end node to backtrack from
		var InitialParent = ds_list_find_value(ClosedParentList,ClosedListSize-1);
	
		var PathFound = 0;
	
		for(var Current = InitialNode, CurrentParent = InitialParent; !PathFound; i2++){
			i2 = 0;

			ds_list_add(PathList,Current); //add node to path
			ds_list_add(PathList,CurrentParent); //add node parent to path
			var Index = ds_list_find_index(ClosedList,CurrentParent); //finds index of node's parent on ClosedList
		
			Current = ds_list_find_value(ClosedList,Index);
			CurrentParent = ds_list_find_value(ClosedParentList,Index);
		
			var PathFound = (ds_list_find_index(PathList,start_node) != -1); //have we reached our initial node?
		};

	};

	//++++++++++++++++++++++++++++++++++++++++ RETURN THE PATH IN A DS_LIST ++++++++++++++++++++++++++++++++++++++++++++++++++++

	if(PathComplete) {  //we got a path! return it in a list, inverting the pathlist. remember to clean it up in the object event. 
	
		ds_list_destroy(ClosedList);
		ds_list_destroy(ClosedParentList);
		ds_priority_destroy(OpenList);	
	
		var FinalPath = ds_list_create(); 
		var PathListSize = ds_list_size(PathList)-1;
		for(var j = PathListSize; j > -1; j--) {
			var NodeToAdd = ds_list_find_value(PathList,j)
			if(NodeToAdd != StartNode) {ds_list_add(FinalPath,NodeToAdd)}
		};
		
		ds_list_destroy(PathList);
		//draw_text(x+100,y-30,"PATH ACQUIRED")
		//ds_list_draw(FinalPath,x,y-300)
		var PathText;
		if(toggle = 1) {PathText = ds_list_write(FinalPath) toggle = 0};
		ds_list_destroy(FinalPath);
		return PathText;
	};


	if(!PathComplete){  //we didn't get a path, return -1		
		ds_list_destroy(ClosedList);
		ds_list_destroy(ClosedParentList);
		ds_priority_destroy(OpenList);
		//draw_text(x,y,"NO PATH FOUND")
		return -1;
	};	 
};

#endregion

#region Movement based on A-star

function AStarMovement(PathList,ClosedList) {
	
	//supply the function with a dslist of the path itself and a closed list of nodes
	
	//find our starting node
	var LOSList = ds_list_create();
	var NodesInLos = nodes_in_los(600,o_platform,o_navnode,x,y-50,ClosedList);
	if(NodesInLos != -1) {
		ds_list_read(LOSList,NodesInLos);	
		StartNode = ds_list_nearest(LOSList,x,y-50,0);
	};
	ds_list_destroy(LOSList);
	
	//If we are not actively engaged, and our target refresh is available, find a new target node
	if(!firing && (TargetNodeTimer[0] > TargetNodeTimer[1])) {
		var LOSList = ds_list_create();
		var NodesInLos = nodes_in_los(600,o_platform,o_navnode,MyTarget.x,MyTarget.y-50,-1);	
		if(NodesInLos != -1) {
			ds_list_read(LOSList,NodesInLos);	
			TargetNode = ds_list_nearest(LOSList,MyTarget.x,MyTarget.y-50,0);
		};
		ds_list_destroy(LOSList);
		TargetNodeTimer[0] = 0;
	};
	
	
	
	
}; //function end bracket astar movement
#endregion











