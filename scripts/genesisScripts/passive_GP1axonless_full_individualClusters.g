// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonFunctions.g


include ../../commonGPFull/make_GP_library_nochans.g

setupClocks {1e-5} {1e-5} {1}
//load compartments with ion channels
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full
setupHinesSolver {cellpath}

doPreparations {cellpath}

deleteall -force
str cluster = "ProxA"
str clusteredSynch = "true"
rundur = 2
STN_rate = 2.5//10
include ../../commonGPFull/simulateSynaptic_individualClusters.g



quit
