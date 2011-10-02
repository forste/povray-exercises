#include "colors.inc"

background {
  color White
}

#declare CAM_LS = <0,5,-7>;

#declare STICKER_DEPTH = 0.0125;
#declare STICKER_MARGIN = 0.05;

#declare RX_BOX_MAIN_WIDTH = 1;

#declare RX_BOX_MAIN_START_X = -1.5;
#declare RX_BOX_MAIN_START_Y = 0;
#declare RX_BOX_MAIN_START_Z = -1.5;


camera {
  location CAM_LS
  look_at  <0, 0, 0>
}

light_source {
  CAM_LS
  color White
}

light_source {
  <-2,2,-3>
  color White
}

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


object { RX_CUBE }