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

#declare EGG_TEX = texture {
  pigment{color Yellow}
}

#declare EGG_RADIUS = 1.5;
#declare EGG_UPPER_HALF_Y_SCALE = 1.75;

#declare EGG_UPPERPART =
  intersection{
    sphere{<0,0,0>,EGG_RADIUS scale <1,EGG_UPPER_HALF_Y_SCALE,1>}
    box{<-EGG_RADIUS,0,-EGG_RADIUS>,<EGG_RADIUS,EGG_UPPER_HALF_Y_SCALE*EGG_RADIUS,EGG_RADIUS>}
  }

#declare EGG_LOWERPART =
  intersection{
    sphere{<0,0,0>,EGG_RADIUS}
    box{<-EGG_RADIUS,-EGG_RADIUS,-EGG_RADIUS>,<EGG_RADIUS,0,EGG_RADIUS>}
  }

#declare EGG =
  union{ object{Egg_upperpart }
    object{Egg_lowerpart}
    texture{Egg_Tex}
  }

object { Egg rotate <0,0,-45> translate <1,-1,0>}
//object { Egg scale .7 translate <1,-1,0>}