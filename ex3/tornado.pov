//TODO use random characteristics, use fuzzy texture

#include "colors.inc"

#declare DEPTH = 80;

#declare MIN_LEVEL = 9;
#declare T_MAJ_INIT = 5;
#declare T_MAJ_INC = 0.1;
#declare T_MIN = 0.2;
#declare T_TRANS_INIT = <0,0,0>;
#declare T_TRANS_INC = <0,T_MIN,0>;
#declare CAMERA_DISTANCE_TO_T = 8;
#declare Random_1 = seed(1153);

#macro Make_Torus(major, minor)
  torus {
    major,
    minor
    texture {
      pigment {
	color rgb<rand(Random_1),rand(Random_1),rand(Random_1)>
      }
      finish {
	reflection {
	  .18
	}
      }
    }
  }
#end

#declare CAMERA_Y=CAMERA_DISTANCE_TO_T;
#macro Make_Tornado(
  in_level, //number of torus
  maj_init, //size of major radius of first (bottom) torus
  maj_inc_default, //default increase of major radius each subsequent torus
  trans_inc, //increase of translation (should be y*minor)
  minor, //minor radius
  maj_max //highest major radius this tornado can use (if highest is used, stop building more torus)
)
  #local maj = maj_init;
  #local trans = T_TRANS_INIT;
  #local level = in_level;
  #local maj_inc = maj_inc_default;
  #local maj_max_this = 0;
  #while(level>0)
    #if(maj < maj_max)
      object {
	Make_Torus(maj, minor)
	translate trans
	#local rand_rotation = rand(Random_1)*2;
	rotate x*rand_rotation
      }
      #local rand02 = rand(Random_1);
      #local maj_inc = maj_inc_default;

      #if(rand02 > 0.8)
	#local maj_inc = -maj_inc_default;
      #end
      #if(rand02 > 0.9)
	#local maj_inc = 0;
      #end
      #local maj_mod = (rand(Random_1)/5)-0.1; //creates random numbers 0.1 above or below zero
      #local maj = maj+maj_inc+maj_mod;
      
      #if(maj > maj_max_this)
	#local maj_max_this = maj;
      #end
      #local trans = trans+trans_inc;
      #local level = level-1;
    #else
      #local level = 0;
    #end
  #end
  #if(in_level>MIN_LEVEL)
    Make_Tornado(
      in_level/2,
      maj_init/2,
      maj_inc_default/2,
      trans_inc/2,
      minor/2,
      maj_max*0.8)
  #end
#end


/***************************** OBJECTS ******************************/

camera {
  location <0,20,0>
  look_at <0,0,0>
}

light_source {
  <0,0,5>
  White
}

background {
  color Yellow
}

Make_Tornado(DEPTH, T_MAJ_INIT, T_MAJ_INC, T_TRANS_INC, T_MIN, 8000)