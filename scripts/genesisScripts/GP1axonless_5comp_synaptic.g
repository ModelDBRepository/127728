// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

modelName = "5comp"
//modelNamePassive = "5comp"
compListFilename = "../../commonGPRedu/gp1dendritenames_5comp.asc"
STNfilename 	= "../../commonGPRedu/gp1dendritenames_5comp_forSyns.asc"
num_STN			= 3
striatumfname 	= "../../commonGPRedu/gp1dendritenames_5comp_forSyns.asc"
num_striatum_compts = 3

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

include ../../commonGPRedu/make_GP_library.g

setupClocks {1e-5} {5e-5} {1}
//load compartments with ion channels
readcell ../../commonGPRedu/GP1_5comp.p {cellpath} -hsolve
setupCurrentInjection_5comp
setupHinesSolver {cellpath}

doPreparations {cellpath}

deleteall -force
str clusteredSynch = "false"
rundur = 100
STN_rate = 10
striatum_rate = 0
include ../../commonGPRedu/simulateSynaptic_5comp_clusteredSynch.g
quit
