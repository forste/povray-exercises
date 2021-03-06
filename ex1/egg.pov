#include "colors.inc"

//http://www.f-lohmueller.de/pov_tut/x_sam/sam_390e.htm

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

#declare Egg_Tex = texture {
  pigment{color Yellow}
}



#declare Egg =
  union{
    sphere{<0,0,0>,1 scale<1.2,1,1>}
    texture{Egg_Tex}
  }

object { Egg rotate <0,-25,0>}
//object { Egg scale .7 translate <1,-1,0>}