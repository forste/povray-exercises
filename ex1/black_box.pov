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

#declare PB_BOT = cylinder {
  <1,-1,0>,
  <1,0.5,0>,
  0.5
  pigment { color Grey }
}

#declare PB_TOP_INNER = cylinder {
  <1,0.5,0>,
  <1,0.6,0>,
  0.35
  pigment { color Grey }
}

#declare PB_TOP_OUTER = torus {
  0.5, 0.08          // major and minor radius
//  rotate -90*x      // so we can see it from the top
  pigment { Grey }
  translate <1,0.5,0>
}

union {
  object {
    PB_BOT
  }
  object {
    PB_TOP_INNER
  }
  object {
    PB_TOP_OUTER
  }
}
  