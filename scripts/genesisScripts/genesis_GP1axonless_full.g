// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonGPRedu/read_mvDir_basefilename.g 
include ../../commonFunctions.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

include ../../commonGPFull/make_GP_library.g
rundur = 2
setupClocks {1e-5} {1e-5} {rundur}

//load compartments with ion channels
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full 
setupHinesSolver {cellpath}

doPreparations {cellpath}

//do current injections
str pulseToUse = "/pulseSoma"
injectCurrent {-100} {pulseToUse} {cellpath}
injectCurrent {40} {pulseToUse} {cellpath}
injectCurrent {100} {pulseToUse} {cellpath}
injectCurrent {200} {pulseToUse} {cellpath}
injectCurrent {500} {pulseToUse} {cellpath}
//set somatic current injection back to 0
injectCurrent {0} {pulseToUse} {cellpath}


str pulseToUse = "/pulseDist"
injectCurrent {-100} {pulseToUse} {cellpath}
//injectCurrent {0} {pulseToUse} {cellpath}
injectCurrent {40} {pulseToUse} {cellpath}
injectCurrent {100} {pulseToUse} {cellpath}
injectCurrent {200} {pulseToUse} {cellpath}
injectCurrent {500} {pulseToUse} {cellpath}

quit
