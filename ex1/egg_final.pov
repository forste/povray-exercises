#include "colors.inc"

background {
  color White
}

camera {
  location <0,0,-11>
  look_at  <0, 0, 0>
}

light_source {
  <9,15,-3>
  color White
}

//
//////////////////// PLANE ////////////////////
//

plane {
  y, 0
  pigment {
    color White
  }
  finish {
    reflection {
      .45
    }
    
    
  }
  
}

#declare EGG_TEX = texture {
  pigment{color Yellow}
}

#declare EGG_RADIUS = 2.5;
#declare EGG_UPPER_HALF_Y_SCALE = 1.5;

#declare EGG_UPPERPART =
  intersection{
    sphere{<0,0,0>,EGG_RADIUS scale <1,EGG_UPPER_HALF_Y_SCALE,1>}
    box{<-EGG_RADIUS,0,-EGG_RADIUS>,
      <EGG_RADIUS, EGG_UPPER_HALF_Y_SCALE * EGG_RADIUS,EGG_RADIUS>}
  }

#declare EGG_LOWERPART =
  intersection{
    sphere{<0,0,0>,EGG_RADIUS}
    box{<-EGG_RADIUS,-EGG_RADIUS,-EGG_RADIUS>,<EGG_RADIUS,0,EGG_RADIUS>}
  }

#declare EGG =
  union{
    object{EGG_UPPERPART }
    object{EGG_LOWERPART}
    texture{EGG_TEX}
    translate y
  }

object {
  EGG
}