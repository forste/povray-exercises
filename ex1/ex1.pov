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

box {
  <0,0,0>,
  <1,1,1>
  pigment { color Blue }
  rotate y*35
  rotate x*-5
}


