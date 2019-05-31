// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

modelName = "5comp"
//modelNamePassive = "5comp"
STNfilename 	= "../../commonGPRedu/gp1dendritenames_5comp.asc"
num_STN			= 3
striatumfname 	= "../../commonGPRedu/gp1dendritenames_5comp.asc"
num_striatum_compts = 3

include ../../commonGPRedu/make_GP_library_nochans.g

setupClocks {1e-5} {5e-5} {1}
//load compartments with ion channels
readcell ../../commonGPRedu/GP1_5comp.p {cellpath} -hsolve
setupCurrentInjection_GP_5comp
setupHinesSolver {cellpath}

doPreparations {cellpath}

deleteall -force
str cluster = "MidDistA"
str clusteredSynch = "true"
rundur = 100
STN_rate = 5//10
include ../../commonGPRedu/simulateSynaptic_5comp_individualClusters.g

deleteall -force
str cluster = "MidDistA"
str clusteredSynch = "true"
rundur = 100
STN_rate = 10
include ../../commonGPRedu/simulateSynaptic_5comp_individualClusters.g

quit
