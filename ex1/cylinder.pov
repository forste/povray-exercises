#include "colors.inc"

#declare C_LS = <5,0,0>;

background {
  color White
}

camera {
  location C_LS
  look_at  <0, 0,  0>
}

light_source {
  C_LS
  color White
}

#declare CYCL = cylinder {
      <0, 0, 0>,     // Center of one end
      <3, 0, 0>,     // Center of other end
      1            // Radius
      pigment {
	color Blue
      }
}

#declare PEN_ORIG_X = 0;
#declare PEN_ORIG_Y = 0;
#declare PEN_ORIG_Z = 0;
#declare PEN_TRI_WIDTH = 0.1;
#declare PEN_TRI_INTERVAL = 0.2;

#declare PEN_TRI_START_1STQ = <0,0,-1>;

#declare TRI = polygon {
  7,
  <0, 0, -1>,
  <0, 0.1, -1>,
  <0, 0, 0>,
  <3, 0, 0>,
  <3, 0.1, -1>,
  <3, 0, -1>,
  <0, 0, -1>
  pigment {
    color Green
  }
}



//difference {
//  object { CYCL }
  object { TRI }
//}


