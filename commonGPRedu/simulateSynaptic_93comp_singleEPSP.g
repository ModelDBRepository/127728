include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPRedu/GP1_93comp.p {cellpath} -hsolve
setupCurrentInjection_93comp

//add synapses to appropriate compartments	
STNtimetablename = "../../commonGPFull/timetables/times_justAt1s.asc"
include ../../commonGPRedu/reduced_read_STN_syns_inclNMDA_atCertainTimes

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
