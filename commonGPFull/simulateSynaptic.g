include ../../commonGPFull/make_GP_library_nochans.g
setupClocks {1e-5} {5e-5} {rundur}
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve

//add synapses to appropriate compartments	
include ../../commonGPFull/read_STN_syns
include ../../commonGPFull/read_striatum_syns_allSoma

setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_saveLocally
