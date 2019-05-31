//set default param values for GP simulations.
//Any param value can be overwritten subsequently.

str midDistACompts = "../../commonGPFull/gp1MidDistClustA.asc"
float somaticInjection = 0
str stncompartment
int currentSynapseIndex = 0
int numSTNsynapses
str modelName = "full"
str modelNamePassive = "full"
float numSynchronizedGroups
float dt
str clusteredSynch
str saveListFilename
float skipCompts
str compListFilename = "../../commonGPFull/gp1dendritenames_sorted_by_edist.asc"

str allcompsfilename 	= "../../commonGPFull/gp1allcompnames.asc"
int ncomps 			= 512	// total # compartments in model. 
					// Keep this up to date!
str dendfilename 	= "../../commonGPFull/gp1dendritenames_sorted_by_edist.asc"
int num_dendcomps 		= 511	// total # dendritic compartments

str STNfilename 	= "../../commonGPFull/gp1dendritenames_sorted_by_edist.asc"
str STNtimetablename
float num_STN			= 511	// # STN inputs

str striatumfname 	= "../../commonGPFull/gp1dendritenames_sorted_by_edist.asc"
int num_striatum_compts 	= 511

float PI = 3.14159

//Passive properties
float RA = 1.74		// uniform
float CM = 0.024	// all unmyelinated regions
float CM_my = 0.00024	// myelinated axon segments.
float RM_sd = 1.47 	// soma
float RM_ax = {RM_sd}	// unmyelinated axonal regions
float RM_my = 10	// myelinated axon segments.
float ELEAK_sd  = -0.060	// soma & dend
float ELEAK_ax	= -0.060	// axon
float EREST_ACT = -0.060
