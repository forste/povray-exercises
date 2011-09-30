#include "colors.inc"

background {
  color White
}
// camera {
//   location <0, 3, -3>
//   look_at  <0, 0,  0>
// }

//front
// camera {
//   location <0, 0, -3>
//   look_at  <0, 0, 0>
// }

//right side
camera {
  location <4, 3, 3>
  look_at  <0, 0, 0>
}

light_source {
  <-2, 3, 2>
  color White
}

#declare One_Part_Translate = -1;

#declare RedO = texture {
  pigment { color rgb<0.8, 0.2, 0.2> }
  finish { ambient 0.2 diffuse 0.5 }
}
#declare GreenO = texture {
  pigment { color rgb<0.2, 0.8, 0.2> }
  finish { ambient 0.2 diffuse 0.5 }
}
#declare BlueO = texture {
  pigment { color rgb<0.2, 0.2, 0.8> }
  finish { ambient 0.2 diffuse 0.5 }
}
#declare One_Part = mesh {
  /* top side */
  triangle {
    <-0, 1, 0>, <0, 1, 1>, <1, 1, 1>
    texture { RedO }
  }
  triangle {
    <-0, 1, 0>, <1, 1, 0>, <1, 1, 1>
    texture { RedO }
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
    texture { GreenO }
  }
  triangle {
    < 1, 0, 0>, <1, 1, 1>, <1, 0, 1>
    texture { GreenO }
  }
  /* front side */
  triangle {
    < 0, 0, 0>, <1, 0, 0>, <1, 1, 0>
    texture { BlueO }
  }
  triangle {
    < 0, 0, 0>, <1, 1, 0>, <0, 1, 0>
    texture { BlueO }
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


// #declare One_Part = box {
//   <0,0,0>,
//   <1,1,1> 
//   pigment { color Blue }
// //  rotate y*35
// //  rotate x*-5
// }

#declare One_Row = union {
   object { One_Part }
   object { One_Part
     translate One_Part_Translate*x
   }
  object { One_Part
     translate One_Part_Translate*x*2
   }
}

#declare One_Floor = union {
  object { One_Row }
  object { One_Row
    translate One_Part_Translate*z
  }
  object { One_Row
    translate One_Part_Translate*z*2
  }
}

#declare The_Whole = union {
  object { One_Floor
    rotate y*45
    translate <0,0,-0.75>
    }
  object { One_Floor
    translate One_Part_Translate*y
  }
  object { One_Floor
    translate One_Part_Translate*y*2
  }
}


object { The_Whole }

//object { One_Part}