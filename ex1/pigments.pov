#include "colors.inc"
camera {
  location <1, 1, -7>
  look_at 0
  angle 36
}
light_source { <1000, 1000, -1000> White }
plane {
  y, -1.5
  pigment { brick Gray75, Red rotate -90*x scale .25 }
}
sphere {
  <0,0,0>, 1
  pigment {
    spotted
    color_map {
      [0.00 color Black]
      [0.85 color White]
    }
  }
}

