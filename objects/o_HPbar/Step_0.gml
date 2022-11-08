

var PL = MyPlayer;

BarHPMax = PL.MaxHP;
BarStaminaMax = PL.MaxStamina;
BarWillMax = PL.MaxWill;

BarHP = round(PL.hp_body_head + PL.hp_body_torso + PL.hp_body_armL + PL.hp_body_armR + PL.hp_body_legL + PL.hp_body_legR);
BarStamina = round(PL.Stamina);
BarWill = round(PL.Will);



