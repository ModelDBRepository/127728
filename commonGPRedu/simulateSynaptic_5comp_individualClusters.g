include ../../commonGPRedu/make_GP_library_nochans.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPRedu/GP1_5comp.p {cellpath} -hsolve
setupCurrentInjection_5comp
//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_5comp_inclNMDA_midDistClustA

numSTNsynapses = 13
synapseStartIndex = 0
stncompartment = "p0b1"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
