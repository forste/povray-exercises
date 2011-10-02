#include "colors.inc"

background {
  color White
}

camera {
  location <0,11,-11>
  look_at  <0, 0, 0>
}

light_source {
  <6,7,0>
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


//object { RX_CUBE rotate y*45}

//
//////////////////// PENS ////////////////////
//

#declare PEN_RADIUS_BOT = 0.33;
#declare PEN_RADIUS_MID = 0.30;
#declare PEN_RADIUS_TOP = PEN_RADIUS_BOT;
#declare PEN_X_START = 0;
#declare PEN_L_BOT = 0.2;
#declare PEN_L_MID = 4.5;
#declare PEN_L_TOP = 3;
#declare PEN_L = PEN_L_BOT + PEN_L_MID + PEN_L_TOP;
#declare PEN_Y = 0;
#declare PEN_Z = 0;

#macro Make_Pen(Color, PEN_Y_START, PEN_Y_END)
  #local PEN_Y_DIFF = abs(PEN_Y_END - PEN_Y_START);
  #if (PEN_Y_START > PEN_Y_END)
    #local PEN_Y_MOD = -1;
  #else
    #local PEN_Y_MOD = 1;
  #end
  
  #debug concat("PEN_Y_DIFF:",str(PEN_Y_DIFF, 5, 5), "\n")
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
  #debug concat("PEN_Y_BOT:",str(PEN_Y_BOT, 5, 5), "\n")
  
  #local PEN_Y_MID = sqrt(
    pow(PEN_L_BOT+PEN_L_MID,2)
    -pow(PEN_X_BOT+PEN_X_MID,2))
  -PEN_Y_BOT;
  #debug concat("PEN_Y_MID:",str(PEN_Y_MID, 5, 5), "\n")
  #local PEN_Y_TOP = sqrt(
    pow(PEN_L_BOT+PEN_L_MID+PEN_L_TOP,2)
    -pow(PEN_X_BOT+PEN_X_MID+PEN_X_TOP,2))
  -PEN_Y_BOT-PEN_Y_MID;
  #debug concat("PEN_Y_TOP:",str(PEN_Y_TOP, 5, 5), "\n")

  union {
    cylinder {
      <PEN_X_START, PEN_Y_START, PEN_Z>,
      <PEN_X_START + PEN_X_BOT, PEN_Y_START + (PEN_Y_BOT * PEN_Y_MOD), PEN_Z>
      PEN_RADIUS_BOT            
      pigment {
	color White 
     }
    }
    cylinder {
      <PEN_X_START + PEN_X_BOT, PEN_Y_START + (PEN_Y_BOT * PEN_Y_MOD), PEN_Z>
      <PEN_X_START + PEN_X_BOT + PEN_X_MID, PEN_Y_START + ((PEN_Y_BOT + PEN_Y_MID)*PEN_Y_MOD), PEN_Z>
      PEN_RADIUS_MID
      pigment {
	color Color
      }
    }
    cylinder {
      <PEN_X_START + PEN_X_BOT + PEN_X_MID, PEN_Y_START + ((PEN_Y_BOT + PEN_Y_MID)*PEN_Y_MOD), PEN_Z>
      <PEN_X_START + PEN_X_BOT + PEN_X_MID + PEN_X_TOP, PEN_Y_START + ((PEN_Y_BOT + PEN_Y_MID + PEN_Y_TOP)*PEN_Y_MOD), PEN_Z>
      PEN_RADIUS_TOP
      pigment {
	color White
      }
    }
  }
#end

//
//////////////////// EGG ////////////////////
//

#declare Egg_Tex = texture {
  pigment{color Yellow}
}

#declare Egg_upperpart =
  intersection{
    sphere{<0,0,0>,1 scale <1,1.75,1>}
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

//
//////////////////// OBJECTS ////////////////////
//

//rubix cube
object { RX_CUBE rotate y*45}

//pens
object {
  Make_Pen(Yellow, PEN_RADIUS_MID*2*1.5, PEN_RADIUS_TOP)
  rotate y*25
  translate <-1.5,0,-1.8>
}  
object {
  Make_Pen(Red, PEN_RADIUS_BOT, PEN_RADIUS_TOP)
  rotate y*160
  translate <4,0,-1>
}
object {
  Make_Pen(Red, PEN_RADIUS_BOT, PEN_RADIUS_TOP*2*1.3)
  rotate y*50
  translate <-5,0,1>
}


//egg
object { Egg }

