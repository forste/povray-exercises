#include "colors.inc"

background {
  color White
}

camera {
  location <0,7,-7>
  look_at  <0, 0, 0>
}

light_source {
  <6,15,1>
  color White
}

light_source {
  <-2,2,-3>
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
}

//
//////////////////// RUBIX-CUBE ////////////////////
//

#declare STICKER_DEPTH = 0.0125;
#declare STICKER_MARGIN = 0.05;

#declare RX_BOX_MAIN_WIDTH = 1;

#declare RX_BOX_MAIN_START_X = -1.5;
#declare RX_BOX_MAIN_START_Y = 0;
#declare RX_BOX_MAIN_START_Z = -1.5;


#declare RX_BOX_MAIN = box {
  <RX_BOX_MAIN_START_X,
   RX_BOX_MAIN_START_Y,
   RX_BOX_MAIN_START_Z>,
  <RX_BOX_MAIN_START_X+RX_BOX_MAIN_WIDTH,
   RX_BOX_MAIN_START_Y+RX_BOX_MAIN_WIDTH,
   RX_BOX_MAIN_START_Z+RX_BOX_MAIN_WIDTH>
  pigment { color Black }
  finish {
    	 phong .75
    	 phong_size 150
    	 }
}

#declare RX_BOX_FRONT = box {
  <RX_BOX_MAIN_START_X + STICKER_MARGIN,
   RX_BOX_MAIN_START_Y + STICKER_MARGIN,
   RX_BOX_MAIN_START_Z>,
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
   RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
   RX_BOX_MAIN_START_Z - STICKER_DEPTH>
  pigment { color Blue }
  finish {
    	 reflection {
            	    .15
    		    }
  }
}

#declare RX_BOX_TOP = box {
  <RX_BOX_MAIN_START_X + STICKER_MARGIN,
   RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH,
   RX_BOX_MAIN_START_Z + STICKER_MARGIN>
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
   RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH + STICKER_DEPTH,
   RX_BOX_MAIN_START_Z + RX_BOX_MAIN_WIDTH - STICKER_MARGIN>
  pigment { color Orange }
}
										 
                                                                          	  
#declare RX_BOX_RIGHT = box {
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH,
   RX_BOX_MAIN_START_Y + STICKER_MARGIN,
   RX_BOX_MAIN_START_Z + STICKER_MARGIN>
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH + STICKER_DEPTH,
   RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
   RX_BOX_MAIN_START_Z + RX_BOX_MAIN_WIDTH - STICKER_MARGIN>
  pigment { color White }
}

#declare RX_BOX = union {
    	 object { RX_BOX_MAIN }
    	 object { RX_BOX_TOP }
    	 object { RX_BOX_FRONT }
    	 object { RX_BOX_RIGHT }

}

#declare RX_ROW = union {
   object { RX_BOX }
   object { RX_BOX
   translate RX_BOX_MAIN_WIDTH*x
   }
  object { RX_BOX
  translate RX_BOX_MAIN_WIDTH*x*2
   }
}

#declare RX_FLOOR = union {
  object { RX_ROW }
  object { RX_ROW
  translate RX_BOX_MAIN_WIDTH*z
  }
  object { RX_ROW
  translate RX_BOX_MAIN_WIDTH*z*2
  }
}

#declare RX_CUBE = union {
  object { RX_FLOOR
  }
  object { RX_FLOOR
    translate RX_BOX_MAIN_WIDTH*y
  }
  object { RX_FLOOR
    translate RX_BOX_MAIN_WIDTH*y*2
    rotate y*-25
  }
}


object { RX_CUBE
  rotate y*45}

//
//////////////////// PENS ////////////////////
//

#declare PEN_RADIUS_BOT = 0.35;
#declare PEN_RADIUS_MID = 0.30;
#declare PEN_RADIUS_TOP = PEN_RADIUS_BOT;
#declare PEN_X_START = 0;
#declare PEN_L_BOT = 0.2;
#declare PEN_L_MID = 4.5;
#declare PEN_L_TOP = 2;
#declare PEN_L = PEN_L_BOT + PEN_L_MID + PEN_L_TOP;
#declare PEN_Y = 0;
#declare PEN_Z = 0;

#macro Make_Pen(Color, PEN_Y_START, PEN_Y_END)
  #local PEN_Y_DIFF = PEN_Y_END - PEN_Y_START;
  #if (PEN_Y_DIFF = 0)
    #local PEN_X = PEN_L;
    #debug concat("PEN_X:",str(PEN_X, 5, 5), "\n")
  #else
    #local PEN_X = sqrt(pow(PEN_L,2)-pow(PEN_Y_DIFF,2));
    #debug concat("PEN_X:",str(PEN_X, 5, 5), "\n")
  #end
  #local COS_BETA = PEN_X / PEN_L;
  #local PEN_X_BOT = PEN_L_BOT * COS_BETA;
  #debug concat("PEN_X_BOT:",str(PEN_X_BOT, 5, 5), "\n")
  #local PEN_X_MID = ((PEN_L_BOT+PEN_L_MID) * COS_BETA)-PEN_X_BOT;
  #debug concat("PEN_X_MID:",str(PEN_X_MID, 5, 5), "\n")
  #local PEN_X_TOP = ((PEN_L_BOT+PEN_L_MID+PEN_L_TOP) * COS_BETA)-PEN_X_BOT-PEN_X_MID;
  #debug concat("PEN_X_TOP:",str(PEN_X_TOP, 5, 5), "\n")
  #local PEN_Y_BOT = sqrt(pow(PEN_L_BOT,2)-pow(PEN_X_BOT,2));
  #local PEN_Y_MID = sqrt(pow(PEN_L_MID,2)-pow(PEN_X_MID,2));
  #local PEN_Y_TOP = sqrt(pow(PEN_L_TOP,2)-pow(PEN_X_TOP,2));

  union {
    cylinder {
      <PEN_X_START, PEN_Y_START, PEN_Z>,
      <PEN_X_START + PEN_X_BOT, PEN_Y_START + PEN_Y_BOT, PEN_Z>
      PEN_RADIUS_BOT            
      pigment {
	color White 
     }
    }
    cylinder {
      <PEN_X_START + PEN_X_BOT, PEN_Y_START + PEN_Y_BOT, PEN_Z>,
      <PEN_X_START + PEN_X_BOT + PEN_X_MID, PEN_Y_START + PEN_Y_BOT + PEN_Y_MID, PEN_Z>
      PEN_RADIUS_MID
      pigment {
	color Color
      }
    }
    cylinder {
      <PEN_X_START + PEN_X_BOT + PEN_X_MID, PEN_Y_START + PEN_Y_BOT + PEN_Y_MID, PEN_Z>,
      <PEN_X_START + PEN_X_BOT + PEN_X_MID + PEN_X_TOP, PEN_Y_START + PEN_Y_BOT + PEN_Y_MID + PEN_Y_TOP, PEN_Z>
      PEN_RADIUS_TOP
      pigment {
	color White
      }
    }
  }
#end

Make_Pen(Yellow, 0, 0)
      



//bottom
#declare PEN_BOT = cylinder {
      <-2.2, 0, 0>,     // Center of one end
      <-2, 0, 0>,     // Center of other end
      0.35            // Radius
      pigment {
	color White
      }
}

//middle
#declare PEN_MID = cylinder {
      <-2, 0, 0>,     // Center of one end
      <2.5, 0, 0>,     // Center of other end
      0.30            // Radius
      pigment {
	color Yellow
      }
}

//top
#declare PEN_TOP = cylinder {
      <2.5, 0, 0>,     // Center of one end
      <4.5, 0, 0>,     // Center of other end
      0.35            // Radius
      pigment {
	color White
      }
}

#declare PEN = union {
  object { PEN_BOT }
  object { PEN_MID }
  object { PEN_TOP }
}

// object { PEN
//   translate <0,2,-2>
//   rotate y*35
//   rotate x*-35
// }