include ../../commonGPRedu/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}
readcell ../../commonGPRedu/GP1_98comp.p {cellpath} -hsolve

//add synapses to appropriate compartments	
include ../../commonGPRedu/reduced_read_STN_syns_98comp_inclNMDA
include ../../commonGPRedu/reduced_read_striatum_syns_98comp
setupCurrentInjection_1comp
setupHinesSolver {cellpath}
doPreparations {cellpath}
runSynaptic_GP_saveLocally
