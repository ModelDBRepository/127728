//GPdefaults - set default param values for GP simulations.
//	Any param value can be overwritten subsequently.

str midDistACompts
float somaticInjection = 0
float numSynchronizedGroups
float percentSynchronized
float skipCompts
float dt
str stncompartment //this might cause problems with some of my synaptic scripts (although unlikely, I think)
int numSTNsynapses
int synapseStartIndex = 0
int currentSynapseIndex = 0
str STNtimetablename
str clusteredSynch
str modelName
str modelNamePassive

str allcompsfilename
str compListFilename

str dendfilename
int num_dendcomps

str STNfilename
float num_STN


str striatumfname
int num_striatum_compts

float PI = 3.14159

//units are Ohms * m
float RA_sd = 1.74 //this value is actually meaningless, because the axial resistance for the soma is never used
float RA_prox = 1.74
float RA_dist = 1.74

//units are Ohms * m^2
float RM_sd = 1.47
float RM_prox = 1.47
float RM_dist = 1.47

//units are Farads / m^2
float CM_sd = 0.024
float CM_prox = 0.024
float CM_dist = 0.024

float ELEAK_sd  = -0.060	// soma & dend
float EREST_ACT = -0.060

