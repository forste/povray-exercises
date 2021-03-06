//
// Stephan Fortelny
// Computer Graphics
// Exercise 1
// 6/10/11
//

#include "colors.inc"

#declare LS = <30,45,15>;

background {
  color White
}

camera {
  location <0,8.5,-9>
  look_at  <0, 0, 0>
}

light_source {
  LS
  color White
  looks_like {
    sphere {
      LS
      8
    }
  }
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
    ambient 0.35
    diffuse 0.5
    
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
    phong .80
    specular 0.7
    phong_size 150
    ambient 0.6
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
    ambient 0.3
    specular 0.5
  }
}

#macro Make_RX_BOX_TOP(TOPCOLOR)
  box {
    <RX_BOX_MAIN_START_X + STICKER_MARGIN,
    RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH,
    RX_BOX_MAIN_START_Z + STICKER_MARGIN>
    <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
    RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH + STICKER_DEPTH,
    RX_BOX_MAIN_START_Z + RX_BOX_MAIN_WIDTH - STICKER_MARGIN>
    pigment { color TOPCOLOR }
    finish {        
      ambient 0.45
      specular 0.5
    }
  }
#end
										 
                                                                          	  
#declare RX_BOX_RIGHT = box {
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH,
   RX_BOX_MAIN_START_Y + STICKER_MARGIN,
   RX_BOX_MAIN_START_Z + STICKER_MARGIN>
  <RX_BOX_MAIN_START_X + RX_BOX_MAIN_WIDTH + STICKER_DEPTH,
   RX_BOX_MAIN_START_Y + RX_BOX_MAIN_WIDTH - STICKER_MARGIN,
   RX_BOX_MAIN_START_Z + RX_BOX_MAIN_WIDTH - STICKER_MARGIN>
  pigment {
    color rgb<1,1,1>
  }
  finish {
    ambient 0.3
    specular 0.5
  }
}

#macro Make_RX_BOX(TOPCOLOR)
  union {
    object { RX_BOX_MAIN }
    Make_RX_BOX_TOP(TOPCOLOR)
    object { RX_BOX_FRONT }
    object { RX_BOX_RIGHT }
  }
#end

#macro Make_RX_ROW(TOPCOLOR)
  union {
    object { Make_RX_BOX(TOPCOLOR) }
    object { Make_RX_BOX(TOPCOLOR)
      translate RX_BOX_MAIN_WIDTH*x
    }
    object { Make_RX_BOX(TOPCOLOR)
      translate RX_BOX_MAIN_WIDTH*x*2
    }
  }
#end

#macro Make_RX_FLOOR(TOPCOLOR)
  union {
    object { Make_RX_ROW(TOPCOLOR) }
    object { Make_RX_ROW(TOPCOLOR)
      translate RX_BOX_MAIN_WIDTH*z
    }
    object { Make_RX_ROW(TOPCOLOR)
      translate RX_BOX_MAIN_WIDTH*z*2
    }
  }
#end

#declare RX_CUBE = union {
  object { Make_RX_FLOOR(Black)
  }
  object { Make_RX_FLOOR(Black)
    translate RX_BOX_MAIN_WIDTH*y
  }
  object { Make_RX_FLOOR(Orange)
    translate RX_BOX_MAIN_WIDTH*y*2
    rotate y*-25
  }
}

//
//////////////////// PENS ////////////////////
//

#declare PEN_RADIUS_BOT = 0.33;
#declare PEN_RADIUS_MID = 0.30;
#declare PEN_RADIUS_TOP = PEN_RADIUS_BOT;
#declare PEN_RADIUS_TOP_DIFF = 0.03;
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
      finish {
        ambient 0.2
        phong 0.3
      }
    }
    
    #local XS = PEN_X_START + PEN_X_BOT + PEN_X_MID;
    #local XE = XS + PEN_X_TOP;
    #local YBM = PEN_Y_BOT + PEN_Y_MID;
    #local YBMT = YBM + PEN_Y_TOP;
    #local Y_DIFF = PEN_RADIUS_TOP/sqrt(2);
    #local Z_DIFF = Y_DIFF;

    
    #macro Make_Pen_Diff(PEN_Y_DIFF, PEN_Z_DIFF)
      cylinder {
	<XS,
	PEN_Y_START + ((YBM + PEN_Y_DIFF)*PEN_Y_MOD),
	PEN_Z + PEN_Z_DIFF>
	<XE,
	PEN_Y_START + ((YBMT + PEN_Y_DIFF)*PEN_Y_MOD),
	PEN_Z + PEN_Z_DIFF>
	PEN_RADIUS_TOP_DIFF
      }
    #end
    
    difference {
      cylinder {
	<XS, PEN_Y_START + ((YBM) * PEN_Y_MOD), PEN_Z>
	<XE, PEN_Y_START + ((YBMT)*PEN_Y_MOD), PEN_Z>
	PEN_RADIUS_TOP
	pigment {
	  color White
	}
	finish {
	  ambient 0.3
	}
      }
      Make_Pen_Diff(PEN_RADIUS_TOP,0)
      Make_Pen_Diff(Y_DIFF,Z_DIFF)
      Make_Pen_Diff(0,PEN_RADIUS_TOP)
      Make_Pen_Diff(-Y_DIFF,Z_DIFF)
      Make_Pen_Diff(-PEN_RADIUS_TOP,0)
      Make_Pen_Diff(-Y_DIFF,-Z_DIFF)
      Make_Pen_Diff(0,-PEN_RADIUS_TOP)
      Make_Pen_Diff(Y_DIFF,-Z_DIFF)
    }
    

  }
#end

//
//////////////////// EGG ////////////////////
//

#declare EGG_TEX_BLACK = rgb<0,0,0>;
#declare EGG_TEX_BEIG = rgb<151,140,118>/130;

#declare EGG_TEX = texture {
  pigment {
    marble
    turbulence 0.5
    color_map {
      [0.00 color EGG_TEX_BLACK]
      [0.50 color EGG_TEX_BEIG]
      [0.95 color EGG_TEX_BLACK]
    }
  }
  finish {
    reflection 0.3
  }
}

// #declare EGG_RADIUS = 2.5;
// #declare EGG_UPPER_HALF_Y_SCALE = 1.5;

// #declare EGG_UPPERPART =
//   intersection{
//     sphere{<0,0,0>,EGG_RADIUS scale <1,EGG_UPPER_HALF_Y_SCALE,1>}
//     box{<-EGG_RADIUS,0,-EGG_RADIUS>,
//       <EGG_RADIUS, EGG_UPPER_HALF_Y_SCALE * EGG_RADIUS,EGG_RADIUS>}
//   }

// #declare EGG_LOWERPART =
//   intersection{
//     sphere{<0,0,0>,EGG_RADIUS}
//     box{<-EGG_RADIUS,-EGG_RADIUS,-EGG_RADIUS>,<EGG_RADIUS,0,EGG_RADIUS>}
//   }

// #declare EGG =
//   union{
//     object{EGG_UPPERPART }
//     object{EGG_LOWERPART}
//     texture{EGG_TEX}
//     translate y
//   }

#declare EGG =
//  union{
    sphere{
      <0,0,0>,1
      scale<1.2,1,1>
      texture{
	EGG_TEX
      }
    }
//  }

//
//////////////////// PHOTOBOX ////////////////////
//

#declare PB_TEX = texture {
  pigment {
    color rgb<0.10,0.10,0.10>*2
  }
  finish {
        ambient 0.5
        phong 0.6
    
  }
  
  
}

#declare PB_BOT = cylinder {
  <1,0,0>,
  <1,1.5,0>,
  0.5
  texture {
    PB_TEX
  }
}

#declare PB_TOP_INNER = cylinder {
  <1,1.5,0>,
  <1,1.6,0>,
  0.35
  texture {
    PB_TEX
  }
}

#declare PB_TOP_OUTER = torus {
  0.5, 0.08          
  texture {
    PB_TEX
  }
  translate <1,1.5,0>
}

#declare PB = union {
  object {
    PB_BOT
  }
  object {
    PB_TOP_INNER
  }
  object {
    PB_TOP_OUTER
  }
}

//
//////////////////// OBJECTS ////////////////////
//

//rubix cube
object { RX_CUBE rotate y*45}

//pens
#declare PEN_TEX_PURPLE = rgb<153,64,117>/145;
#declare PEN_TEX_RED = rgb<186,64,57>/155;
#declare PEN_TEX_YELLOW = rgb<190,139,46>/155;
#declare PEN_TEX_LIGHTRED = rgb<159,83,90>/145;
object {
  Make_Pen(PEN_TEX_YELLOW, PEN_RADIUS_MID*2*1.5, PEN_RADIUS_TOP)
  rotate y*25
  translate <-1.5,0,-1.8>
}

object {
  Make_Pen(PEN_TEX_LIGHTRED, PEN_RADIUS_BOT, PEN_RADIUS_TOP)
  rotate y*160
  translate <4,0,-1>
}
object {
  Make_Pen(PEN_TEX_RED, PEN_RADIUS_BOT, PEN_RADIUS_TOP*2*1.3)
  rotate y*50
  translate <-5,0,1>
}

//purple
object {
  Make_Pen(PEN_TEX_PURPLE, PEN_RADIUS_BOT, PEN_RADIUS_TOP*2*1.3)
  rotate y*-160
  translate <3.7,2.7,-1.5>
}

//egg
// object {
//   EGG
//   rotate <120,70,60>
//   scale <0.5,0.5,0.5> 
//   translate <3,0.7,-2>
// }
object {
  EGG
  scale 1.55
  rotate <0,-35,0>
  translate <4.5,0.7,-2>
}

//photobox
object {
  PB
  scale 1.9
  translate <1.5,0,0.8>
}