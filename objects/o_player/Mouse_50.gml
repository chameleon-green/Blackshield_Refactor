

if(cycle) {

cycle = 0;

var RPM = wpn_active.ROF;
var time = ( 1000/(RPM/60) )/16.7;
alarm[0] = time;
alarm[1] = 2;

skeleton_animation_set_ext(wpn_active.animation_group.fire,3)

var flash = irandom(3);
skeleton_slot_color_set("slot_flash",wpn_active.flash_color1,1);
skeleton_attachment_set("slot_flash",wpn_active.flash_type[flash]);
skeleton_attachment_set("slot_flash_core",wpn_active.flash_type[flash] + " core");

};
