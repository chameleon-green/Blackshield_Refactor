

audio_listener_set_position(0,x,y,0);

//------------------------------------------- STATE TOGGLES --------------------------------------------

var IsRanged = string_count("ranged",wpn_active.item_type);
var ICActive = 0;
if(variable_instance_exists(id,"MyIC")) {var ICActive = MyIC.active};
CanShoot = (!sprinting && !rolling && !reloading && !swinging && IsRanged && !ICActive);
CanReload = (!rolling && !reloading && !swinging);
CanMove = (!rolling && !swinging);
CanRoll = (!rolling && !swinging);


PlayerStatsCalculator();
TickEffect(BuffList);
if(HP > MaxHP) {HP = MaxHP};
if(Stamina > MaxStamina) {Stamina = MaxStamina};
if(Will > MaxWill) {Will = MaxWill};

//------------------------------------------- MOVEMENT STUFF -----------------------------------------------

PlayerMovement();

ImpactScript(o_bullet,"head",hbox_head,collisions_list,0);
ImpactScript(o_bullet,["torso","torso","torso","torso","armL","armL","armR","armR"],hbox_torso,collisions_list,0);
ImpactScript(o_bullet,["legL","legR"],hbox_legs,collisions_list,0);

//-------------------------------------------- HEAT STUFF --------------------------------------------------
	var IsRanged = string_count("ranged",wpn_active.item_type);
	if(IsRanged){
	
	if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};
	if(spread_angle < (wpn_active.spread)) {spread_angle = wpn_active.spread};
	var Heat = wpn_active_heat;
	var HeatCap = wpn_active.heat_capacity;
	var Reduction = 1/(sqr(wpn_active_heat/wpn_active.heat_capacity)+0.5); //more heat = slower rate
	var HeatReduction = Reduction*(HeatCap/200);
	if(wpn_active_heat > 0) {wpn_active_heat -= HeatReduction};
	if(wpn_active_heat < 0) {wpn_active_heat = 0};
	
	};


