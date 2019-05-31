include ../../commonGPFull/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full
//add synapses to appropriate compartments	

STNfilename = "../../commonGPFull/gp1dendritenames_sorted_by_edist.asc"
//STNfilename = "../../commonGPFull/gp1MidProxClustA.asc"
include ../../commonGPFull/read_STN_syns_inclNMDA


//make certain clustered synapses fire using timetables
STNfilename = "../../commonGPFull/gp1ProxClustA.asc"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1MidProxClustA.asc"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1MidDistClustA.asc"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1DistClustA.asc"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch



STNfilename = "../../commonGPFull/gp1ProxClustB.asc"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1MidProxClustB.asc"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1MidDistClustB.asc"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

STNfilename = "../../commonGPFull/gp1DistClustB.asc"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPFull/read_STN_syns_clusteredSynch

//add inhibitory randomly timed distributed background
include ../../commonGPFull/read_striatum_syns

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
