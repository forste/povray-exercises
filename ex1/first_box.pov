#include "colors.inc"

background {
  color White
}

#declare CAM_LS = <2,3,-3>;

camera {
  location CAM_LS
  look_at  <0, 0,  0>
}

light_source {
  CAM_LS
  color White
}

#declare Red = texture {
  pigment { color rgb<0.8, 0.2, 0.2> }
  finish { ambient 0.2 diffuse 0.5 }
}
#declare Green = texture {
  pigment { color rgb<0.2, 0.8, 0.2> }
  finish { ambient 0.2 diffuse 0.5 }
}
#declare Blue = texture {
  pigment { color rgb<0.2, 0.2, 0.8> }
  finish { ambient 0.2 diffuse 0.5 }
}

// box {
  //   <0,0,0>,
  //   <1,1,1>
  //   pigment { color Blue }
  //   rotate y*35
  //   rotate x*-5
  // }

mesh {
  /* top side */
  triangle {
    <-0, 1, 0>, <0, 1, 1>, <1, 1, 1>
    texture { Red }
  }
  triangle {
    <-0, 1, 0>, <1, 1, 0>, <1, 1, 1>
    texture { Red }
  }
  /* bottom side */
  triangle {
    <-0, 0, 0>, <0, 0, 1>, <1, 0, 1>
  }
  triangle {
    <-0, 0, 0>, <1, 0, 0>, <1, 0, 1>
  }
  /* left side */
  triangle {
    < 0, 0, 0>, <0, 1, 0>, <0, 1, 1>
  }
  triangle {
    < 0, 0, 0>, <0, 1, 1>, <0, 0, 1>
  }
  /* right side */
  triangle {
    < 1, 0, 0>, <1, 1, 0>, <1, 1, 1> 
    texture { Green }
  }
  triangle {
    < 1, 0, 0>, <1, 1, 1>, <1, 0, 1>
    texture { Green }
  }
  /* front side */
  triangle {
    < 0, 0, 0>, <1, 0, 0>, <1, 1, 0>
    texture { Blue }
  }
  triangle {
    < 0, 0, 0>, <1, 1, 0>, <0, 1, 0>
    texture { Blue }
  }
  /* back side */
  triangle {
    < 0, 0, 1>, <1, 0, 1>, <1, 1, 1>
  }
  triangle {
    < 0, 0, 1>, <1, 1, 1>, <0, 1, 1>
  }
  texture {
    pigment { color rgb<0.9, 0.9, 0.9> }
    finish { ambient 0.2 diffuse 0.7 }
  }
}


