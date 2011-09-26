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
      <-2.2, 0, 0>,     // Center of one end
      <-2, 0, 0>,     // Center of other end
      0.55            // Radius
      pigment {
	color White
      }
      rotate y*30
}

cylinder {
      <-2, 0, 0>,     // Center of one end
      <1, 0, 0>,     // Center of other end
      0.5            // Radius
      pigment {
	color Yellow
      }
      rotate y*30
}

cylinder {
      <1, 0, 0>,     // Center of one end
      <3, 0, 0>,     // Center of other end
      0.55            // Radius
      pigment {
	color White
      }
      rotate y*30
}
