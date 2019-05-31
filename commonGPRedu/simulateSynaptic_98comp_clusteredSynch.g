include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}

readcell ../../commonGPRedu/GP1_98comp.p {cellpath} -hsolve
setupCurrentInjection_98comp
//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_inclNMDA

numSTNsynapses = 2
stncompartment = "p0b1[6]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p0b1[7]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p0b1[8]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3
stncompartment = "p0b1[9]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2
stncompartment = "p0b1[10]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 2
stncompartment = "p1[16]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2
stncompartment = "p1[17]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//2
stncompartment = "p1[18]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2//3
stncompartment = "p1[19]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2
stncompartment = "p1[20]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2
stncompartment = "p1[21]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 2//0
stncompartment = "p0b1[25]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//4
stncompartment = "p0b1[26]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//4
stncompartment = "p0b1[27]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//5
stncompartment = "p0b1[28]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2//0
stncompartment = "p0b1[29]" 
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 7//13
stncompartment = "p2b2[24]" //25
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6//0
stncompartment = "p2b2[25]" //26
STNtimetablename = "../../commonGPFull/timetables/times_DistClustA" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch



numSTNsynapses = 4//7
stncompartment = "p2b2[5]"
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 5//6
stncompartment = "p2b2[6]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 4//0
stncompartment = "p2b2[7]" 
STNtimetablename = "../../commonGPFull/timetables/times_ProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 2//0
stncompartment = "p0b1[17]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//0
stncompartment = "p0b1[18]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//7
stncompartment = "p0b1[19]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2//6
stncompartment = "p0b1[20]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 3//0
stncompartment = "p0b1[21]"
STNtimetablename = "../../commonGPFull/timetables/times_MidProxClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 11//13
stncompartment = "p2b2[19]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 2//0
stncompartment = "p2b2[20]"
STNtimetablename = "../../commonGPFull/timetables/times_MidDistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

numSTNsynapses = 7//0
stncompartment = "p2b2[26]" //27 
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch
numSTNsynapses = 6//0
stncompartment = "p2b2[27]" //28
STNtimetablename = "../../commonGPFull/timetables/times_DistClustB" @ {STN_rate} @ "Hz.asc"
include ../../commonGPRedu/reduced_read_STN_syns_clusteredSynch

include ../../commonGPRedu/reduced_read_striatum_syns

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_clusteredSynch_saveLocally
