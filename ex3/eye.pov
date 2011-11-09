#include "colors.inc"

#declare CLS=<0,1,5>;

background {
  color White
}

camera {
  location CLS
  look_at  <0,1, 0>
}

light_source {
  CLS
  color White
}

#declare EYE_R = 1;
#declare EYE_TEX = texture {
  pigment {
    color Yellow
  }
}
#declare EYE = sphere {
  <0,EYE_R,0>,
  EYE_R
  scale <1.5, 1, 0.5>
  texture {
    EYE_TEX
  }
}

object {
  EYE
}

