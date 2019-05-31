include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}
readcell ../../commonGPRedu/GP1_14comp.p {cellpath} -hsolve

//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_14comp_inclNMDA
include ../../commonGPRedu/reduced_read_striatum_syns_14comp
setupCurrentInjection_1comp
setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_saveLocally
