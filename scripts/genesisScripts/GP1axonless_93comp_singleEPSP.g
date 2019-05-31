// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

modelName = "93comp"
compListFilename = "../../commonGPRedu/gp1allcompnames_93comp.asc"

STNfilename 	= "../../commonGPRedu/gp1singleEPSPcompname_93comp.asc"
num_STN			= 91

striatumfname 	= "../../commonGPRedu/gp1dendritenames_93comp_forSyns.asc"
num_striatum_compts = 91

clusteredSynch = "false"
G_AMPA    	= 2e-9//0.25e-9
G_NMDA    	= {G_AMPA}
rundur = 2
STN_rate = 1
striatum_rate = 0
include ../../commonGPRedu/simulateSynaptic_93comp_singleEPSP.g


quit
