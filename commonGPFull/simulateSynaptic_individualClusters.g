include ../../commonGPFull/make_GP_library.g
setupClocks {1e-5} {1e-5} {rundur}

readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full
//add synapses to appropriate compartments	
STNfilename = "../../commonGPFull/gp1DistClustB.asc"
include ../../commonGPFull/read_STN_syns_inclNMDA

//make certain clustered synapses fire using timetables
STNfilename = "../../commonGPFull/gp1DistClustB.asc"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
