// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonFunctions.g

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.
include ../../commonGPFull/make_GP_library_nochans.g	
setupClocks {1e-5} {1e-5} {1}

//load compartments with ion channels
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_1comp
setupHinesSolver {cellpath}
doPreparations {cellpath}
injectMockAP_forCurrentsAnalysis_saveLocally {cellpath}
quit
