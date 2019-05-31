include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPRedu/GP1_50comp.p {cellpath} -hsolve
setupCurrentInjection_50comp
//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_inclNMDA

numSTNsynapses = 5
stncompartment = "p0b1[3]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p0b1[4]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p0b1[5]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch


numSTNsynapses = 4//5
stncompartment = "p1[8]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5//4
stncompartment = "p1[9]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4
stncompartment = "p1[10]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 1//0
stncompartment = "p0b1[12]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6//7
stncompartment = "p0b1[13]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6
stncompartment = "p0b1[14]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 13
stncompartment = "p2b2[12]"
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch




numSTNsynapses = 1//13
stncompartment = "p2b2[2]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 12//0
stncompartment = "p2b2[3]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 4//13
stncompartment = "p0b1[8]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5//0
stncompartment = "p0b1[9]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4//0
stncompartment = "p0b1[10]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 13
stncompartment = "p2b2[9]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 13
stncompartment = "p2b2[13]" //12
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

include ../../commonGPRedu/reduced_read_striatum_syns

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
