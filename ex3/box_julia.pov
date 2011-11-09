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


box {
    <-2, -2, 0>, <2, 2, 0.1>
    pigment {
      julia <0.353, 0.288>, 60
      interior 1, 1
      Color_map { 
          [0 rgb 0]
        [0.2 rgb x]
        [0.4 rgb x+y]
        [1 rgb 1]
        [1 rgb 0]
      }
    }
  }