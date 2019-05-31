
silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

modelName = "41comp"

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.
include ../../commonGPRedu/make_GP_library_nochans.g	
setupClocks {1e-5} {1e-5} {1}

//load compartments with ion channels
readcell ../../commonGPRedu/GP1_41comp.p {cellpath} -hsolve
setupCurrentInjection_1comp
setupHinesSolver {cellpath}
doPreparations {cellpath}
injectMockAP_forCurrentsAnalysis_saveLocally {cellpath}
quit
