#include "colors.inc"

background {
  color White
}
camera {
  location <0, 3, -3>
  look_at  <0, 0,  0>
}

light_source {
  <-2, 3, 2>
  color White
}

cylinder {
  <1,-1,0>,
  <1,0.5,0>,
  0.5
  pigment { color Grey }
}

cylinder {
  <1,0.5,0>,
  <1,0.6,0>,
  0.35
  pigment { color Grey }
}

torus {
  0.5, 0.08          // major and minor radius
//  rotate -90*x      // so we can see it from the top
  pigment { Grey }
  translate <1,0.5,0>
}