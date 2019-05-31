include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPRedu/GP1_93comp.p {cellpath} -hsolve
setupCurrentInjection_93comp

//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_inclNMDA
//include ../../commonGPRedu/reduced_read_STN_syns_93comp_inclNMDA_MidProxA

numSTNsynapses = 2//1
stncompartment = "p0b1b1" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 7//8
stncompartment = "p0b1b1[1]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p0b1b1b1" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch


numSTNsynapses = 3
stncompartment = "p1[3]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p1b1" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6
stncompartment = "p1b1b2" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch


numSTNsynapses = 5
stncompartment = "p0b1b1b2[3]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5
stncompartment = "p0b1b1b2b2" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p0b1b1b2b2[1]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 6//7
stncompartment = "p2b2b2[6]"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5//4
stncompartment = "p2b2b2b1"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2
stncompartment = "p2b2b2b1[1]"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch


numSTNsynapses = 1
stncompartment = "p2b2" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p2b2b1" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6
stncompartment = "p2b2b1b1" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p2b2b1b1[1]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 2
stncompartment = "p0b1b2[2]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5
stncompartment = "p0b1b2[3]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6
stncompartment = "p0b1b2[4]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 4
stncompartment = "p2b2b1b2b2b2b2" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5
stncompartment = "p2b2b1b2b2b2b2[1]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p2b2b1b2b2b2b2b1" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 7
stncompartment = "p2b2b1b2b1[4]" 
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6
stncompartment = "p2b2b1b2b1[5]" 
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

include ../../commonGPRedu/reduced_read_striatum_syns

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
