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

#declare Egg_upperpart =
  intersection{
    sphere{<0,0,0>,1 scale<1,1.75,1>}
    box{<-1,0,-1>,<1,1.75,1>}
  }

#declare Egg_lowerpart =
  intersection{
    sphere{<0,0,0>,1 scale<1,1,1>}
    box{<-1,-1,-1>,<1,0,1>}
  }

#declare Egg =
  union{ object{Egg_upperpart }
    object{Egg_lowerpart}
    texture{Egg_Tex}
  }

object { Egg scale .7 rotate x*20 translate<1,0,0>}