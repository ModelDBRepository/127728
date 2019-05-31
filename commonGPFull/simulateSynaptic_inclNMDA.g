include ../../commonGPFull/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve

//add synapses to appropriate compartments	
include ../../commonGPFull/read_STN_syns_inclNMDA
include ../../commonGPFull/read_striatum_syns

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_saveLocally
