

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

ImpactScript(o_bullet,"head",hbox_head,collisions_list);
ImpactScript(o_bullet,["torso","torso","torso","torso","armL","armL","armR","armR"],hbox_torso,collisions_list);
ImpactScript(o_bullet,["legL","legR"],hbox_legs,collisions_list);



