// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonFunctions.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

include ../../commonGPFull/make_GP_library.g

setupClocks {1e-5} {5e-5} {1}
//load compartments with ion channels
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full
setupHinesSolver {cellpath}

doPreparations {cellpath}

deleteall -force
clusteredSynch = "false"
rundur = 100
STN_rate = 10
striatum_rate = 0
include ../../commonGPFull/simulateSynaptic_clusteredSynch.g

quit
